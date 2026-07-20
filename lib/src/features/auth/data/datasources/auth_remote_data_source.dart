import 'package:codemap2/src/config/api_urls.dart';
import 'package:codemap2/src/services/dio_client.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(String email, String password);
  Future<AuthResponseModel> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  );
  Future<void> logout();
  Future<void> resetPassword(String email);
}

class ApiAuthRemoteDataSource implements AuthRemoteDataSource {
  final DioClient _dioClient;

  ApiAuthRemoteDataSource(this._dioClient);

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final response = await _dioClient.post(
      APIUrls.login,
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(_asMap(response.data));
  }

  @override
  Future<AuthResponseModel> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    final response = await _dioClient.post(
      APIUrls.signup,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    );
    return AuthResponseModel.fromJson(_asMap(response.data));
  }

  @override
  Future<void> logout() async {
    await _dioClient.post(APIUrls.logout);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _dioClient.post(APIUrls.resetPassword, data: {'email': email});
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException('Expected JSON object response');
  }
}

