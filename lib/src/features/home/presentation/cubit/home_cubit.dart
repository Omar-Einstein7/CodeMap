import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/features/course/domain/entities/course.dart';
import 'package:codemap2/src/features/course/domain/repositories/course_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CourseRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  void loadHomeData() {
    emit(HomeLoading());
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getFeaturedCourses(),
      ]);
      final categories = results[0] as List<String>;
      final featured = results[1] as List<Course>;
      emit(HomeLoaded(
        selectedCategoryIndex: 0,
        categories: categories,
        featuredCourseData: featured,
        recentCourses: featured,
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
}
