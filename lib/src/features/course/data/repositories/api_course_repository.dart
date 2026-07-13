import 'package:codemap2/src/config/api_urls.dart';
import 'package:codemap2/src/services/dio_client.dart';

import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../models/course_api_models.dart';

class ApiCourseRepository implements CourseRepository {
  final DioClient _dioClient;

  ApiCourseRepository(this._dioClient);

  @override
  Future<List<Course>> getCoursesByCategory(CourseCategory category) async {
    final response = await _dioClient.get(
      APIUrls.coursesByCategory(category.name),
    );
    return _parseCourseList(response.data);
  }

  @override
  Future<List<Course>> searchCourses(
    String query,
    CourseCategory category,
  ) async {
    final courses = await getCoursesByCategory(category);
    if (query.trim().isEmpty) return courses;
    return courses
        .where(
          (course) => course.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<List<Course>> globalSearch(String query) async {
    if (query.trim().isEmpty) return [];
    final response = await _dioClient.get(
      APIUrls.searchCourses,
      queryParameters: {'q': query},
    );
    return _parseCourseList(response.data);
  }

  @override
  Future<Course> getCourseDetails(String courseId) async {
    final response = await _dioClient.get(APIUrls.courseDetails(courseId));
    final data = _unwrap(response.data);
    if (data is Map) {
      return CourseModel.fromJson(Map<String, dynamic>.from(data));
    }
    throw const FormatException('Expected course details object');
  }

  List<Course> _parseCourseList(dynamic data) {
    final unwrapped = _unwrap(data);
    if (unwrapped is List) {
      return unwrapped
          .whereType<Map>()
          .map((json) => CourseModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }
    throw const FormatException('Expected course list response');
  }

  dynamic _unwrap(dynamic data) {
    if (data is Map) {
      return data['data'] ??
          data['courses'] ??
          data['course'] ??
          data['favourites'] ??
          data['favorites'] ??
          data;
    }
    return data;
  }
}
