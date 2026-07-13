import '../entities/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCoursesByCategory(CourseCategory category);
  Future<List<Course>> searchCourses(String query, CourseCategory category);
  Future<List<Course>> globalSearch(String query);
  Future<List<String>> getCategories();
  Future<List<Course>> getFeaturedCourses();

  /// Fetches the full course details including Sections and Lessons.
  /// This is separate because the list view doesn't need the full hierarchy.
  Future<Course> getCourseDetails(String courseId);
}
