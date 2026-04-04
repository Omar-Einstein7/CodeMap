import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class NavigationShell extends ConsumerWidget {
  final Widget child;

  const NavigationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeNotifierProvider);
    final theme = Theme.of(context);

    final List<String> tabPaths = [
      '/home',
      '/favourites',
      '/courses',
      '/profile',
    ];

    final String location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();
    int activeIndex = 0;
    if (location.startsWith('/favourites')) {
      activeIndex = 1;
    } else if (location.startsWith('/courses')) {
      activeIndex = 2;
    } else if (location.startsWith('/profile')) {
      activeIndex = 3;
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
        backgroundColor: theme.primaryColor,
        child: Icon(
          isLightTheme ? Icons.brightness_3 : Icons.sunny,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.favorite_border,
          Icons.library_books,
          Icons.person,
        ],
        activeIndex: activeIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        backgroundColor: theme.primaryColor,
        activeColor: Colors.white,
        inactiveColor: Colors.white54,
        onTap: (index) {
          context.go(tabPaths[index]);
        },
      ),
    );
  }
}
