import '../entities/course_progress.dart';

abstract class ProgressRepository {
  /// Fetches the user's progress for a specific course.
  Future<CourseProgress> getCourseProgress(String userId, String courseId);

  /// Marks a lesson as completed and updates the course progress.
  Future<void> completeLesson(String userId, String courseId, String lessonId);

  /// Saves a quiz score (if applicable) - Future extension point.
  // Future<void> saveQuizScore(String userId, String lessonId, int score);
}
