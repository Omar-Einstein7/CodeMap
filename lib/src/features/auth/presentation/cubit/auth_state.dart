import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// The state when the app is checking for an existing session (e.g., checking tokens).
class AuthInitial extends AuthState {}

/// The state during a login, signup, or session check operation.
class AuthLoading extends AuthState {}

/// The state when the user is successfully authenticated.
class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// The state when no user is authenticated.
class AuthUnauthenticated extends AuthState {}

/// The state after a successful one-time action (e.g., signup complete, reset email sent).
class AuthActionSuccess extends AuthState {
  final String message;
  const AuthActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// The state when an authentication operation fails.
class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
