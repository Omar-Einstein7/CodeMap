import 'package:codemap2/src/config/api_urls.dart';
import 'package:codemap2/src/services/dio_client.dart';

import '../../domain/entities/course_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../models/course_api_models.dart';

class ApiProgressRepository implements ProgressRepository {
  final DioClient _dioClient;

  ApiProgressRepository(this._dioClient);

  @override
  Future<CourseProgress> getCourseProgress(
    String userId,
    String courseId,
  ) async {
    final response = await _dioClient.get(APIUrls.progress(userId, courseId));
    final data = _unwrap(response.data);
    if (data is Map) {
      final json = Map<String, dynamic>.from(data);
      json.putIfAbsent('userId', () => userId);
      json.putIfAbsent('courseId', () => courseId);
      return CourseProgressModel.fromJson(json);
    }
    throw const FormatException('Expected progress object response');
  }

  @override
  Future<void> completeLesson(
    String userId,
    String courseId,
    String lessonId,
  ) async {
    await _dioClient.post(APIUrls.completeLesson(userId, courseId, lessonId));
  }

  dynamic _unwrap(dynamic data) {
    if (data is Map) return data['data'] ?? data['progress'] ?? data;
    return data;
  }
}
