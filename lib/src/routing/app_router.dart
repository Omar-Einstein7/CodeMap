
import 'package:codemap2/src/imports/core_imports.dart';

import 'package:codemap2/src/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:codemap2/src/features/auth/presentation/pages/login_screen.dart';
import 'package:codemap2/src/features/auth/presentation/pages/new_password_screen.dart';
import 'package:codemap2/src/features/auth/presentation/pages/signup_screen.dart';
import 'package:codemap2/src/features/auth/presentation/pages/verify_code_screen.dart';
import 'package:codemap2/src/features/home/presentation/pages/home_screen.dart';
import 'package:codemap2/src/features/course/presentation/pages/search_screen.dart';
import 'package:codemap2/src/features/course/presentation/pages/course_list_screen.dart';
import 'package:codemap2/src/features/course/presentation/pages/course_content_screen.dart';
import 'package:codemap2/src/features/course/domain/entities/course.dart';
import 'package:codemap2/src/features/course/presentation/pages/category_list_screen.dart';
import 'package:codemap2/src/features/course/presentation/pages/course_detail_screen.dart';
import 'package:codemap2/src/features/favourite/presentation/pages/favourite_screen.dart';
import 'package:codemap2/src/features/navigation/presentation/pages/navigation_shell.dart';
import 'package:codemap2/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:codemap2/src/features/profile/presentation/pages/settings_screen.dart';
import 'package:codemap2/src/features/splash/presentation/pages/splash_screen.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    navigatorKey: _rootNavigatorKey,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forget-password',
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: '/verify-code',
        builder: (context, state) => const VerifyCodeScreen(),
      ),
      GoRoute(
        path: '/new-password',
        builder: (context, state) => const NewPasswordScreen(),
      ),
      // ShellRoute for authenticated users with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => NavigationShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
            routes: [
              GoRoute(
                path: 'search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/favourites',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: FavouriteScreen()),
          ),
          GoRoute(
            path: '/courses',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CategoryListScreen()),
            routes: [
              GoRoute(
                path: 'courses/:category',
                builder: (context, state) {
                  final categoryName = state.pathParameters['category']!;
                  final category = CourseCategory.values.firstWhere(
                    (e) => e.name == categoryName,
                    orElse: () => CourseCategory.ai,
                  );
                  return CourseListScreen(category: category);
                },
              ),
              GoRoute(
                path: 'course-detail/:courseId',
                builder: (context, state) {
                  final courseId = state.pathParameters['courseId']!;
                  // Retrieve the course object from extra if available, otherwise fetch it
                  final course = state.extra as Course?;

                  if (course != null) {
                    return CourseDetailScreen(course: course);
                  }

                  // Fallback: This will trigger the loading state in CourseDetailScreen
                  return CourseDetailScreen(
                    course: Course(
                      id: courseId,
                      name: 'Loading...',
                      imageUrl: '',
                      category: CourseCategory.ai,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'content',
                    builder: (context, state) {
                      final courseId = state.pathParameters['courseId']!;
                      final course = state.extra as Course?;

                      if (course != null) {
                        return CourseContentScreen(course: course);
                      }

                      return CourseContentScreen(
                        course: Course(
                          id: courseId,
                          name: 'Loading...',
                          imageUrl: '',
                          category: CourseCategory.ai,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen()),
            routes: [
              GoRoute(
                path: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final sessionState = sl<SessionCubit>().state; // Get current state
      final bool isAuthenticated = sessionState is SessionAuthenticated;
      final bool isUnauthenticated = sessionState is SessionUnauthenticated;

      final bool isGoingToAuth =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forget-password' ||
          state.matchedLocation == '/verify-code' ||
          state.matchedLocation == '/new-password';
      final bool isGoingToSplash = state.matchedLocation == '/splash';

      // If the session is still initializing, stay on splash
      if (sessionState is SessionInitial || sessionState is SessionLoading) {
        return isGoingToSplash ? null : '/splash';
      }

      // If unauthenticated, but trying to go to a protected route, redirect to login
      if (isUnauthenticated && !isGoingToAuth && !isGoingToSplash) {
        return '/login';
      }

      // If authenticated, but trying to go to login/signup/splash, redirect to home
      if (isAuthenticated && (isGoingToAuth || isGoingToSplash)) {
        return '/home';
      }

      // No redirect needed
      return null;
    },
  );
}
