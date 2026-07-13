import 'package:codemap2/src/config/api_urls.dart';
import 'package:codemap2/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:codemap2/src/features/course/data/models/course_api_models.dart';
import 'package:codemap2/src/features/course/domain/entities/course.dart';
import 'package:codemap2/src/services/dio_client.dart';

import '../../domain/repositories/favourite_repository.dart';

class ApiFavouriteRepository implements FavouriteRepository {
  final DioClient _dioClient;
  final AuthLocalDataSource _authLocalDataSource;

  ApiFavouriteRepository({
    required DioClient dioClient,
    required AuthLocalDataSource authLocalDataSource,
  }) : _dioClient = dioClient,
       _authLocalDataSource = authLocalDataSource;

  @override
  Future<List<Course>> getFavourites() async {
    final userId = await _currentUserId();
    final response = await _dioClient.get(APIUrls.favourites(userId));
    final data = _unwrap(response.data);
    if (data is List) {
      return data
          .whereType<Map>()
          .map((json) => CourseModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }
    throw const FormatException('Expected favourite course list response');
  }

  @override
  Future<void> addFavourite(Course course) async {
    final userId = await _currentUserId();
    await _dioClient.post(APIUrls.addFavourite(userId, course.id));
  }

  @override
  Future<void> removeFavourite(String courseId) async {
    final userId = await _currentUserId();
    await _dioClient.delete(APIUrls.removeFavourite(userId, courseId));
  }

  @override
  Future<bool> isFavourite(String courseId) async {
    final userId = await _currentUserId();
    final response = await _dioClient.get(
      APIUrls.checkFavourite(userId, courseId),
    );
    final data = _unwrap(response.data);
    if (data is bool) return data;
    if (data is Map) {
      return data['isFavourite'] == true ||
          data['isFavorite'] == true ||
          data['favourite'] == true ||
          data['favorite'] == true;
    }
    return false;
  }

  Future<String> _currentUserId() async {
    final user = await _authLocalDataSource.getCachedUser();
    if (user == null || user.id.isEmpty) {
      throw StateError('No authenticated user found');
    }
    return user.id;
  }

  dynamic _unwrap(dynamic data) {
    if (data is Map) {
      return data['data'] ??
          data['courses'] ??
          data['favourites'] ??
          data['favorites'] ??
          data;
    }
    return data;
  }
}
