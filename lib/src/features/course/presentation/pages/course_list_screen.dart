import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/services/service_locator.dart';
import '../../domain/entities/course.dart';
import '../cubit/course_cubit.dart';
import '../cubit/course_state.dart';
import '../widgets/course_card.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class CourseListScreen extends StatelessWidget {
  final CourseCategory category;

  const CourseListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => sl<CourseCubit>()..loadCourses(category),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(category.displayName),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: theme.textPrimaryColor,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Builder(
                builder: (context) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: theme.glassColor,
                    border: Border.all(color: theme.glassBorder),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      context.read<CourseCubit>().searchCourses(
                        value,
                        category,
                      );
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: theme.textTertiaryColor,
                      ),
                      hintText: "Search courses",
                      hintStyle: TextStyle(
                        color: theme.textTertiaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<CourseCubit, CourseState>(
                  builder: (context, state) {
                    if (state is CourseLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CourseLoaded) {
                      if (state.courses.isEmpty) {
                        return Center(
                          child: Text(
                            "No courses found",
                            style: TextStyle(
                              fontSize: 16,
                              color: theme.textSecondaryColor,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.courses.length,
                        itemBuilder: (context, index) {
                          return CourseCard(course: state.courses[index]);
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
    );
  }
}
