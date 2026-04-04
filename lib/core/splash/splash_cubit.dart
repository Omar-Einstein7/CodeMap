import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/core/di/service_locator.dart' as di;
import 'package:codemap2/core/session/session_cubit.dart';
import 'package:codemap2/core/session/session_state.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _init();
  }

  Future<void> _init() async {
    final sessionCubit = di.sl<SessionCubit>();
    await sessionCubit.initializeSession();
    if (sessionCubit.state is SessionAuthenticated) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
