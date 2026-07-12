import 'package:codemap2/src/features/course/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/services/service_locator.dart';
import 'package:codemap2/src/shared/widgets/widgets.dart';
import '../cubit/course_cubit.dart';
import '../cubit/course_state.dart';
import 'package:codemap2/src/theme/app_theme.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => sl<CourseCubit>(),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        body: GlassBackground(
          child: SafeArea(
            child: Column(
              children: [
                // Search Input
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.glassDark
                                  : AppColors.glassLight,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.glassBorderDark
                                    : AppColors.glassBorderLight,
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                context.read<CourseCubit>().globalSearch(value);
                              },
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: "Search courses...",
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Results
                Expanded(
                  child: BlocBuilder<CourseCubit, CourseState>(
                    builder: (context, state) {
                      if (state is CourseLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CourseLoaded) {
                        if (state.courses.isEmpty && state.query.isNotEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 80,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "No courses found for '${state.query}'",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        } else if (state.query.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 80,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Try searching for keywords like 'Flutter', 'Python'...",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: state.courses.length,
                          itemBuilder: (context, index) {
                            final course = state.courses[index];
                            return CourseCard(course: course);
                          },
                        );
                      } else if (state is CourseError) {
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
