import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/features/course/domain/entities/course.dart';
import 'package:codemap2/src/features/course/domain/repositories/course_repository.dart';
import 'package:codemap2/src/services/recent_courses_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CourseRepository _repository;
  final RecentCoursesService _recentCoursesService;
  StreamSubscription<List<Course>>? _recentSub;

  HomeCubit(this._repository, this._recentCoursesService) : super(HomeInitial());

  void loadHomeData() {
    emit(HomeLoading());
    _recentSub?.cancel();
    _recentSub = _recentCoursesService.recentCoursesStream.listen(_onRecentUpdated);
    _loadData();
  }

  void _onRecentUpdated(List<Course> recent) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(HomeLoaded(
        selectedCategoryIndex: current.selectedCategoryIndex,
        categories: current.categories,
        featuredCourseData: current.featuredCourseData,
        recentCourses: recent,
      ));
    }
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getFeaturedCourses(),
        _recentCoursesService.getRecentCourses(),
      ]);
      final categories = results[0] as List<String>;
      final featured = results[1] as List<Course>;
      final recent = results[2] as List<Course>;
      emit(HomeLoaded(
        selectedCategoryIndex: 0,
        categories: categories,
        featuredCourseData: featured,
        recentCourses: recent,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void selectCategory(int index) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(HomeLoaded(
        selectedCategoryIndex: index,
        categories: currentState.categories,
        featuredCourseData: currentState.featuredCourseData,
        recentCourses: currentState.recentCourses,
      ));
    }
  }

  @override
  Future<void> close() {
    _recentSub?.cancel();
    return super.close();
  }
}
