import 'package:codemap2/src/config/api_urls.dart';
import 'package:codemap2/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:codemap2/src/services/dio_client.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../models/user_profile_model.dart';

class ApiUserProfileRepository implements UserProfileRepository {
  final DioClient _dioClient;
  final AuthLocalDataSource _authLocalDataSource;

  ApiUserProfileRepository({
    required DioClient dioClient,
    required AuthLocalDataSource authLocalDataSource,
  }) : _dioClient = dioClient,
       _authLocalDataSource = authLocalDataSource;

  @override
  Future<UserProfile> getUserProfile() async {
    final userId = await _currentUserId();
    final response = await _dioClient.get(APIUrls.userProfile(userId));
    final data = _unwrap(response.data);
    if (data is Map) {
      return UserProfileModel.fromJson(Map<String, dynamic>.from(data));
    }
    throw const FormatException('Expected profile object response');
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    final userId = await _currentUserId();
    final parts = profile.name.trim().split(RegExp(r'\s+'));
    await _dioClient.put(
      APIUrls.userProfile(userId),
      data: {
        'firstName': parts.isEmpty ? profile.name : parts.first,
        'lastName': parts.length > 1 ? parts.sublist(1).join(' ') : '',
        'profileImageUrl': profile.imageUrl,
        if (profile.bio != null) 'bio': profile.bio,
      },
    );
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
      return data['data'] ?? data['user'] ?? data['profile'] ?? data;
    }
    return data;
  }
}
