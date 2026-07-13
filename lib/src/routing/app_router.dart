
import 'package:codemap2/src/imports/core_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: _rootNavigatorKey,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyCode,
        builder: (context, state) => const VerifyCodeScreen(),
      ),
      GoRoute(
        path: AppRoutes.newPassword,
        builder: (context, state) => const NewPasswordScreen(),
      ),
      // StatefulShellRoute for authenticated users with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavigationShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
                routes: [
                  GoRoute(
                    path: 'search',
                    builder: (context, state) => const SearchScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favourites,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: FavouriteScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.courses,
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
                      final course = state.extra as Course?;

                      if (course != null) {
                        return CourseDetailScreen(course: course);
                      }

                      return CourseDetailScreen(
                        course: Course(
                          id: courseId,
                          name: 'Loading...',
                          imageUrl: 'images2/img.png',
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
                              imageUrl: 'images2/img.png',
                              category: CourseCategory.ai,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
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
      ),
    ],
    redirect: (context, state) {
      final sessionState = context.read<SessionCubit>().state; // Get current state
      final bool isAuthenticated = sessionState is SessionAuthenticated;
      final bool isUnauthenticated = sessionState is SessionUnauthenticated;

      final bool isGoingToAuth =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signup ||
          state.matchedLocation == AppRoutes.forgotPassword ||
          state.matchedLocation == AppRoutes.verifyCode ||
          state.matchedLocation == AppRoutes.newPassword;
      final bool isGoingToSplash = state.matchedLocation == AppRoutes.splash;

      // If the session is still initializing, stay on splash
      if (sessionState is SessionInitial || sessionState is SessionLoading) {
        return isGoingToSplash ? null : AppRoutes.splash;
      }

      // If unauthenticated, but trying to go to a protected route, redirect to login
      if (isUnauthenticated && !isGoingToAuth && !isGoingToSplash) {
        return AppRoutes.login;
      }

      // If authenticated, but trying to go to login/signup/splash, redirect to home
      if (isAuthenticated && (isGoingToAuth || isGoingToSplash)) {
        return AppRoutes.home;
      }

      // No redirect needed
      return null;
    },
  );
}
