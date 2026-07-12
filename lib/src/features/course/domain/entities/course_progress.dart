import 'package:equatable/equatable.dart';

enum LessonStatus {
  locked,
  available,
  inProgress,
  completed,
}

class CourseProgress extends Equatable {
  final String courseId;
  final String userId;
  final double percentComplete;
  final String? lastAccessedLessonId;
  final DateTime? lastAccessedAt;
  final Map<String, LessonStatus> lessonStatus; // Key: LessonId

  const CourseProgress({
    required this.courseId,
    required this.userId,
    this.percentComplete = 0.0,
    this.lastAccessedLessonId,
    this.lastAccessedAt,
    this.lessonStatus = const {},
  });

  bool isLessonCompleted(String lessonId) {
    return lessonStatus[lessonId] == LessonStatus.completed;
  }

  @override
  List<Object?> get props => [
        courseId,
        userId,
        percentComplete,
        lastAccessedLessonId,
        lastAccessedAt,
        lessonStatus,
      ];
}
