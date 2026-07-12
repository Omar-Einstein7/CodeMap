import 'dart:ui';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class NavigationShell extends StatelessWidget {
  final Widget child;

  const NavigationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
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

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isLightTheme) {
        final glassColor = isLightTheme
            ? AppColors.glassLight
            : AppColors.glassDark;
        return Scaffold(
          backgroundColor: isLightTheme ? AppColors.bgLight : AppColors.bgDark,
          body: Stack(
            children: [
              // Gradient background for glass to blur
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: glassBackgroundGradient(isLightTheme),
                  ),
                ),
              ),
              // Subtle backdrop blur overlay for frosted glass effect
              Positioned.fill(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      color: isLightTheme
                          ? Colors.white.withOpacity(0.15)
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              // Actual content
              child,
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            backgroundColor: theme.primaryColor,
            child: Icon(
              isLightTheme ? Icons.brightness_3 : Icons.sunny,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
            backgroundColor: glassColor,
            activeColor: theme.primaryColor,
            inactiveColor: isLightTheme ? Colors.black38 : Colors.white38,
            blurEffect: true,
            elevation: 0,
            onTap: (index) {
              context.go(tabPaths[index]);
            },
          ),
        );
      },
    );
  }
}
