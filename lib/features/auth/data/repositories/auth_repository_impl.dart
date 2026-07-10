import 'package:codemap2/src/utils/failures.dart';
import 'package:codemap2/src/utils/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      // In a real app, the remote data source would return a token that we cache here
      // For now, mocking token caching
      await localDataSource.cacheToken('mock_token');
      await localDataSource.cacheUser(userModel);
      return Success(userModel);
    } catch (e) {
      return Error(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Result<User>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signup(
        firstName,
        lastName,
        email,
        password,
      );
      // Similar to login, cache user after signup
      await localDataSource.cacheToken('mock_token');
      await localDataSource.cacheUser(userModel);
      return Success(userModel);
    } catch (e) {
      return Error(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCache();
      return const Success(null);
    } catch (e) {
      return Error(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Result<User?>> checkAuthStatus() async {
    try {
      final cachedUser = await localDataSource.getCachedUser();
      final hasToken = await localDataSource.getToken() != null;
      if (cachedUser != null && hasToken) {
        return Success(cachedUser);
      }
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> resetPassword(String email) async {
    try {
      await remoteDataSource.resetPassword(email);
      return const Success(null);
    } catch (e) {
      return Error(AuthFailure(e.toString()));
    }
  }
}
