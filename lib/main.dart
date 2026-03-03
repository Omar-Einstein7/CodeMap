import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:codemap2/features/navigation/presentation/pages/navigation_shell.dart';
import 'package:codemap2/features/favourite/presentation/pages/favourite_screen.dart';
import 'package:codemap2/features/profile/presentation/pages/profile_screen.dart';
import 'package:codemap2/features/profile/presentation/pages/settings_screen.dart';
import 'package:codemap2/features/course/presentation/pages/category_list_screen.dart';
import 'package:codemap2/features/auth/presentation/pages/signup_screen.dart';

// New Architecture imports

import 'core/theme/app_theme.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/auth/presentation/pages/forget_password_screen.dart';
import 'features/auth/presentation/pages/verify_code_screen.dart';
import 'features/auth/presentation/pages/new_password_screen.dart';

import 'core/di/service_locator.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // No need to manually read SharedPreferences here as it's handled by GetIt
  runApp(const ProviderScope(child: CodeMapApp()));
}

class CodeMapApp extends ConsumerWidget {
  const CodeMapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CodeMap',
      theme: themeNotifier.getTheme(),
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
      // The starting point of our refactored app
      home: const SplashScreen(),

      // Maintaining legacy routes to avoid breaking the app during migration
      routes: {
        "Login": (context) => const LoginScreen(),
        "Signup": (context) => const SignupScreen(),
        "ForgetPassword": (context) => const ForgetPasswordScreen(),
        "VerifyCode": (context) => const VerifyCodeScreen(),
        "NewPassword": (context) => const NewPasswordScreen(),
        "Main": (context) => const NavigationShell(),
        "Courses": (context) => const CategoryListScreen(),
        "Fav": (context) => const FavouriteScreen(),
        "Profile": (context) => const ProfileScreen(),
        "Settings": (context) => const SettingsScreen(),
      },
    );
  }
}
