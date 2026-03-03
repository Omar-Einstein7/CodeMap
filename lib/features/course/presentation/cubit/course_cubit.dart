import 'package:codemap2/features/course/domain/entities/course.dart';
import 'package:codemap2/features/course/domain/repositories/course_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _repository;

  CourseCubit(this._repository) : super(CourseInitial());

  Future<void> loadCourses(CourseCategory category) async {
    emit(CourseLoading());
    try {
      final courses = await _repository.getCoursesByCategory(category);
      emit(CourseLoaded(courses: courses, category: category));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> searchCourses(String query, CourseCategory category) async {
    // We don't necessarily want to emit loading for search as it can be jittery
    try {
      final courses = await _repository.searchCourses(query, category);
      emit(CourseLoaded(courses: courses, category: category, query: query));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
