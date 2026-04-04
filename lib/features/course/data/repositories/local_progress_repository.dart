import '../../domain/repositories/progress_repository.dart';

class LocalProgressRepository implements ProgressRepository {
  // Simulating local storage (e.g., SharedPreferences or Hive)
  // Map<UserId, Map<CourseId, Set<LessonId>>>
  final Map<String, Map<String, Set<String>>> _completedLessons = {};

  @override
  Future<void> completeLesson(String userId, String courseId, String lessonId) async {
    // Simulate disk I/O
    await Future.delayed(const Duration(milliseconds: 300));

    if (!_completedLessons.containsKey(userId)) {
      _completedLessons[userId] = {};
    }
    if (!_completedLessons[userId]!.containsKey(courseId)) {
      _completedLessons[userId]![courseId] = {};
    }

    _completedLessons[userId]![courseId]!.add(lessonId);
  }

  @override
  Future<CourseProgress> getCourseProgress(String userId, String courseId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final completedSet = _completedLessons[userId]?[courseId] ?? {};
    
    // Transform Set<String> to Map<String, LessonStatus>
    final lessonStatusMap = {
      for (var id in completedSet) id: LessonStatus.completed
    };

    // Calculate percentage (mock logic - in real app, we need total lessons from Course entity)
    // For now, we return 0.0 or a mock calculation
    
    return CourseProgress(
      courseId: courseId,
      userId: userId,
      lessonStatus: lessonStatusMap,
      lastAccessedAt: DateTime.now(),
      percentComplete: 0.0, // To be calculated in Domain layer or Service
    );
  }
}
