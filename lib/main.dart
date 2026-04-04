import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemap2/core/theme/app_theme.dart';
import 'package:codemap2/core/session/session_cubit.dart';
import 'package:codemap2/core/session/session_state.dart'; // Import SessionState
import 'package:codemap2/core/di/service_locator.dart' as di;
import 'package:codemap2/core/navigation/app_router.dart';
import 'package:go_router/go_router.dart'; // Import go_router

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const ProviderScope(child: CodeMapApp()));
}

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
        // <--- Add BlocListener here
        listener: (context, state) {
          if (state is SessionAuthenticated) {
            AppRouter.router.go('/home'); // Navigate to home on auth
          } else if (state is SessionUnauthenticated) {
            AppRouter.router.go('/login'); // Navigate to login on unauth
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
