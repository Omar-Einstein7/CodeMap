import 'package:codemap2/features/course/presentation/widgets/course_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/di/service_locator.dart';

import '../cubit/favourite_cubit.dart';
import '../cubit/favourite_state.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => sl<FavouriteCubit>()..loadFavourites(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: theme.primaryColor,
                  ),
                  height: 50,
                  child: const Center(
                    child: Text(
                      "F A V O U R I T E",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                          child: Text(
                            "NO FAVOURITE YET",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: theme.brightness == Brightness.light
                                  ? Colors.black54
                                  : Colors.white54,
                            ),
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
    );
  }
}
