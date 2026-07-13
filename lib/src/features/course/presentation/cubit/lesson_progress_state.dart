import 'package:equatable/equatable.dart';
import '../../domain/entities/course_progress.dart';

sealed class LessonProgressState extends Equatable {
  const LessonProgressState();

  @override
  List<Object?> get props => [];
}

class LessonProgressInitial extends LessonProgressState {}

class LessonProgressLoading extends LessonProgressState {}

class LessonProgressLoaded extends LessonProgressState {
  final CourseProgress progress;

  const LessonProgressLoaded(this.progress);

  @override
  List<Object?> get props => [progress];

  /// Helper to check if a specific lesson is completed
  bool isCompleted(String lessonId) {
    return progress.isLessonCompleted(lessonId);
  }
}

class LessonProgressError extends LessonProgressState {
  final String message;

  const LessonProgressError(this.message);

  @override
  List<Object?> get props => [message];
}
