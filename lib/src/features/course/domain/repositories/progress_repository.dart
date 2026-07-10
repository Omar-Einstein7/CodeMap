/// Represents the status of a specific lesson for a user.
enum LessonStatus {
  locked,
  available,
  inProgress,
  completed,
}

/// Domain entity for user progress on a course.
class CourseProgress {
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
}

abstract class ProgressRepository {
  /// Fetches the user's progress for a specific course.
  Future<CourseProgress> getCourseProgress(String userId, String courseId);

  /// Marks a lesson as completed and updates the course progress.
  Future<void> completeLesson(String userId, String courseId, String lessonId);

  /// Saves a quiz score (if applicable) - Future extension point.
  // Future<void> saveQuizScore(String userId, String lessonId, int score);
}
