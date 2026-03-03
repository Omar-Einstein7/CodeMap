import '../entities/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCoursesByCategory(CourseCategory category);
  Future<List<Course>> searchCourses(String query, CourseCategory category);
}
