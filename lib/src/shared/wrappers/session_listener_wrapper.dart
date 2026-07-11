import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/services/session_state.dart';
import 'package:codemap2/src/routing/app_routes.dart';

class SessionListenerWrapper extends StatelessWidget {
  final Widget child;

  const SessionListenerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listenWhen: (prev, next) => prev.runtimeType != next.runtimeType,
      listener: (context, state) {
        if (state is! SessionInitial) {
          FlutterNativeSplash.remove();
        }
        if (state is SessionAuthenticated) {
          context.go(AppRoutes.home);
        } else if (state is SessionUnauthenticated) {
          context.go(AppRoutes.login);
        }
      },
      child: child,
    );
  }
}
