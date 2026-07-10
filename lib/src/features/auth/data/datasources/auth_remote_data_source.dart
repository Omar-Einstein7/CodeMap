import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String firstName, String lastName, String email, String password);
  Future<void> logout();
  Future<void> resetPassword(String email);
}

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com' && password == '123456') {
      return const UserModel(
        id: '1',
        email: 'test@test.com',
        firstName: 'Omar',
        lastName: 'Ahmed',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<UserModel> signup(String firstName, String lastName, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: '2',
      email: email,
      firstName: firstName,
      lastName: lastName,
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
