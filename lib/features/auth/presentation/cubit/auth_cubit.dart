import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/session/session_cubit.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  final SessionCubit _sessionCubit;

  AuthCubit(this._repository, this._sessionCubit) : super(AuthInitial());

  /// Checks if the user is already authenticated (e.g., checking local tokens).
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final result = await _repository.checkAuthStatus();
    if (result is Success) {
      final user = (result as Success).data;
      if (user != null) {
        _sessionCubit.setSession(user);
        emit(AuthAuthenticated(user));
      } else {
        _sessionCubit.clearSession();
        emit(AuthUnauthenticated());
      }
    } else {
      _sessionCubit.clearSession();
      emit(AuthUnauthenticated());
    }
  }

  /// Handles user login.
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await _repository.login(email: email, password: password);
    if (result is Success) {
      final user = (result as Success).data;
      _sessionCubit.setSession(user);
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthFailure((result as Error).failure.message));
    }
  }

  /// Handles user signup.
  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await _repository.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    if (result is Success) {
      final user = (result as Success).data;
      _sessionCubit.setSession(user);
      emit(const AuthActionSuccess("Signup Successful"));
    } else {
      emit(AuthFailure((result as Error).failure.message));
    }
  }

  /// Handles user logout.
  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _repository.logout();
    if (result is Success) {
      _sessionCubit.clearSession();
      emit(AuthUnauthenticated());
    } else {
      emit(AuthFailure((result as Error).failure.message));
    }
  }

  /// Resets the cubit state back to initial (used for navigating back to login from recovery).
  void reset() => emit(AuthUnauthenticated());
}
