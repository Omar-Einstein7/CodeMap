import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:codemap2/features/home/presentation/pages/home_screen.dart';
import 'package:codemap2/features/course/presentation/pages/category_list_screen.dart';
import 'package:codemap2/features/favourite/presentation/pages/favourite_screen.dart';
import 'package:codemap2/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';

import '../cubit/navigation_cubit.dart';

// Placeholder for Home/Main content if we decide to refactor that too

class NavigationShell extends ConsumerWidget {
  const NavigationShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeNotifierProvider);
    final theme = Theme.of(context);

    final List<Widget> pages = [
      const HomeScreen(),
      const CategoryListScreen(),
      const FavouriteScreen(),
      const ProfileScreen(),
    ];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, activeIndex) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: pages[activeIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  ref.read(themeNotifierProvider.notifier).toggleTheme(),
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
                Icons.lightbulb_outline,
                Icons.favorite_border,
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
              onTap: (index) => context.read<NavigationCubit>().setTab(index),
            ),
          );
        },
      ),
    );
  }
}
