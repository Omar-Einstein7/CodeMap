import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemap2/src/theme/app_theme.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/services/session_state.dart';
import 'package:codemap2/src/services/service_locator.dart' as di;
import 'package:codemap2/src/routing/app_router.dart';

class CodeMapApp extends ConsumerWidget {
  const CodeMapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionCubit>(
          create: (context) => di.sl<SessionCubit>()..initializeSession(),
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
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'CodeMap',
          theme: themeNotifier.getTheme(),
          themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
