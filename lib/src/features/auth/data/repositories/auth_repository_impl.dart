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
      final authResponse = await remoteDataSource.login(email, password);
      await localDataSource.cacheToken(authResponse.token);
      await localDataSource.cacheUser(authResponse.user);
      return Success(authResponse.user);
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
      final authResponse = await remoteDataSource.signup(
        firstName,
        lastName,
        email,
        password,
      );
      await localDataSource.cacheToken(authResponse.token);
      await localDataSource.cacheUser(authResponse.user);
      return Success(authResponse.user);
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
