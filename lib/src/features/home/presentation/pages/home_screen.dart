import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/services/service_locator.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_banner.dart';
import '../widgets/category_selector.dart';
import '../widgets/featured_courses_list.dart';
import '../widgets/recent_courses_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightTheme = theme.brightness == Brightness.light;

    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom Header
                    const HomeHeader(username: 'Omar Ahmed'),

                    // Modern Search Bar
                    HomeSearchBar(
                      onTap: () => context.push('/home/search'),
                    ),

                    // Modernized Banner
                    const HomeBanner(),

                    // Categories Selector
                    CategorySelector(
                      categories: state.categories,
                      selectedIndex: state.selectedCategoryIndex,
                      onTap: (index) =>
                          context.read<HomeCubit>().selectCategory(index),
                    ),

                    // Featured Courses Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                      child: Text(
                        "Featured Courses",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isLightTheme ? Colors.black : Colors.white,
                        ),
                      ),
                    ),

                    // Featured Courses - Glass cards
                    FeaturedCoursesList(
                      courses: state.featuredCourseData,
                      onCourseTap: (course) => context.push(
                        '/courses/course-detail/${course.id}',
                        extra: course,
                      ),
                    ),

                    // Recent Section Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Courses",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isLightTheme ? Colors.black : Colors.white,
                            ),
                          ),
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Recent Courses List - Glass cards
                    RecentCoursesList(
                      courses: state.featuredCourseData,
                      onCourseTap: (course) => context.push(
                        '/courses/course-detail/${course.id}',
                        extra: course,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
