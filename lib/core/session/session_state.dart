import 'package:equatable/equatable.dart';
import '../../../features/auth/domain/entities/user.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionAuthenticated extends SessionState {
  final User user;
  final List<String> enrolledCourseIds;
  final bool isPro;

  const SessionAuthenticated({
    required this.user,
    this.enrolledCourseIds = const [],
    this.isPro = false,
  });

  @override
  List<Object?> get props => [user, enrolledCourseIds, isPro];

  SessionAuthenticated copyWith({
    User? user,
    List<String>? enrolledCourseIds,
    bool? isPro,
  }) {
    return SessionAuthenticated(
      user: user ?? this.user,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      isPro: isPro ?? this.isPro,
    );
  }
}

class SessionUnauthenticated extends SessionState {}
