import 'package:codemap2/src/utils/result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<User>> login({
    required String email,
    required String password,
  });

  Future<Result<User>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Result<void>> logout();

  Future<Result<User?>> checkAuthStatus();

  Future<Result<void>> resetPassword(String email);
}
