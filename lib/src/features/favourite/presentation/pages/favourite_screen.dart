import 'package:codemap2/src/features/course/presentation/widgets/course_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/services/service_locator.dart';
import 'package:codemap2/src/theme/app_theme.dart';
import 'package:codemap2/src/shared/widgets/widgets.dart';
import '../cubit/favourite_cubit.dart';
import '../cubit/favourite_state.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => sl<FavouriteCubit>()..loadFavourites(),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        body: GlassBackground(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "F A V O U R I T E",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<FavouriteCubit, FavouriteState>(
                    builder: (context, state) {
                      if (state is FavouriteLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FavouriteLoaded) {
                        if (state.favourites.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_outline_rounded,
                                  size: 64,
                                  color: theme.textTertiaryColor,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "No favourites yet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: theme.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.favourites.length,
                          itemBuilder: (context, index) {
                            return CourseCard(course: state.favourites[index]);
                          },
                        );
                      } else if (state is FavouriteError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
