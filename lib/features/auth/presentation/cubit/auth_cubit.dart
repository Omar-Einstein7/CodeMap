import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      // TODO: Implement actual login logic with repository
      await Future.delayed(const Duration(seconds: 1));
      if (email == "test@test.com" && password == "123456") {
        emit(const AuthSuccess("Login Successful"));
      } else {
        emit(const AuthFailure("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      // TODO: Implement actual signup logic with repository
      await Future.delayed(const Duration(seconds: 1));
      emit(const AuthSuccess("Signup Successful"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void reset() => emit(AuthInitial());
}
