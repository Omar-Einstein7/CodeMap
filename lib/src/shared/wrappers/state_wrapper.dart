import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/services/service_locator.dart' as di;

class StateWrapper extends StatelessWidget {
  final Widget child;

  const StateWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionCubit>(
          create: (context) => di.sl<SessionCubit>()..initializeSession(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: child,
    );
  }
}
