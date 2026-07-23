import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final CourseRepository _repository;

  CourseDetailCubit(this._repository) : super(CourseDetailInitial());

  Future<void> loadCourseDetails(String courseId, {Course? fallback}) async {
    if (courseId.isEmpty) {
      if (fallback != null) {
        emit(CourseDetailLoaded(fallback));
      } else {
        emit(const CourseDetailError('Course ID is empty'));
      }
      return;
    }
    emit(CourseDetailLoading());
    try {
      final course = await _repository.getCourseDetails(courseId);
      emit(CourseDetailLoaded(course));
    } catch (e) {
      if (fallback != null) {
        emit(CourseDetailLoaded(fallback));
      } else {
        emit(CourseDetailError(e.toString()));
      }
    }
  }
}
