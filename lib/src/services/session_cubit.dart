import 'package:codemap2/src/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:codemap2/src/features/auth/domain/entities/user.dart';

import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository _authRepository;

  SessionCubit(this._authRepository) : super(SessionInitial());

  /// Initializes the session by checking for an existing user in local storage.
  Future<void> initializeSession() async {
    emit(SessionLoading());
    final result = await _authRepository.checkAuthStatus();
    if (result is Success) {
      final user = (result as Success).data;
      if (user != null) {
        // In a real app, we'd also fetch entitlements here
        emit(SessionAuthenticated(user: user));
      } else {
        emit(SessionUnauthenticated());
      }
    } else {
      emit(SessionUnauthenticated());
    }
  }

  /// Sets the session when a user logs in or signs up.
  void setSession(User user) {
    emit(SessionAuthenticated(user: user));
  }

  /// Clears the session when a user logs out.
  void clearSession() {
    emit(SessionUnauthenticated());
  }

  /// Checks if the user is enrolled in a specific course.
  bool isEnrolled(String courseId) {
    final currentState = state;
    if (currentState is SessionAuthenticated) {
      return currentState.isPro || currentState.enrolledCourseIds.contains(courseId);
    }
    return false;
  }

  /// Updates entitlements (e.g., after a purchase).
  void updateEntitlements({List<String>? enrolledCourseIds, bool? isPro}) {
    final currentState = state;
    if (currentState is SessionAuthenticated) {
      emit(currentState.copyWith(
        enrolledCourseIds: enrolledCourseIds,
        isPro: isPro,
      ));
    }
  }
}
