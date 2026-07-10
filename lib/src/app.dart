import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/services/session_state.dart';
import 'package:codemap2/src/services/service_locator.dart' as di;
import 'package:codemap2/src/routing/app_router.dart';

class CodeMapApp extends StatelessWidget {
  const CodeMapApp({super.key});

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
      child: BlocListener<SessionCubit, SessionState>(
        listener: (context, state) {
          if (state is SessionAuthenticated) {
            AppRouter.router.go('/home');
          } else if (state is SessionUnauthenticated) {
            AppRouter.router.go('/login');
          }
        },
        child: BlocBuilder<ThemeCubit, bool>(
          builder: (context, isLightTheme) {
            final themeCubit = context.read<ThemeCubit>();
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'CodeMap',
              theme: themeCubit.themeData(),
              themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}
