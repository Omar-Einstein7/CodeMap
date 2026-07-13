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

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<AuthResponseModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com' && password == '123456') {
      return const AuthResponseModel(
        token: 'mock_token',
        user: UserModel(
          id: '1',
          email: 'test@test.com',
          firstName: 'Omar',
          lastName: 'Ahmed',
        ),
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<AuthResponseModel> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return AuthResponseModel(
      token: 'mock_token',
      user: UserModel(
        id: '2',
        email: email,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
