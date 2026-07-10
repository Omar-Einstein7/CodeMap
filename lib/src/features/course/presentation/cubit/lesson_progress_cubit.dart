import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/progress_repository.dart';
import 'lesson_progress_state.dart';

class LessonProgressCubit extends Cubit<LessonProgressState> {
  final ProgressRepository _repository;

  LessonProgressCubit(this._repository) : super(LessonProgressInitial());

  Future<void> loadProgress(String userId, String courseId) async {
    emit(LessonProgressLoading());
    try {
      final progress = await _repository.getCourseProgress(userId, courseId);
      emit(LessonProgressLoaded(progress));
    } catch (e) {
      emit(LessonProgressError(e.toString()));
    }
  }

  Future<void> completeLesson(String userId, String courseId, String lessonId) async {
    // Optimistic Update: Immediately reflect change in UI if we have current state
    final currentState = state;
    if (currentState is LessonProgressLoaded) {
      // Create a new map with the updated status
      final updatedStatus = Map<String, LessonStatus>.from(currentState.progress.lessonStatus);
      updatedStatus[lessonId] = LessonStatus.completed;

      final updatedProgress = CourseProgress(
        courseId: currentState.progress.courseId,
        userId: currentState.progress.userId,
        percentComplete: currentState.progress.percentComplete, // Ideally recalculate
        lastAccessedAt: DateTime.now(),
        lastAccessedLessonId: lessonId,
        lessonStatus: updatedStatus,
      );
      
      emit(LessonProgressLoaded(updatedProgress));
    }

    try {
      await _repository.completeLesson(userId, courseId, lessonId);
      // Re-fetch to ensure server sync and correct calculations (e.g. percentage)
      // In a real app, the repository might return the updated entity directly
      await loadProgress(userId, courseId);
    } catch (e) {
      // Revert on failure (if needed) or show error
      emit(LessonProgressError("Failed to update progress: ${e.toString()}"));
      // Reload actual state to fix UI
      loadProgress(userId, courseId);
    }
  }
}
