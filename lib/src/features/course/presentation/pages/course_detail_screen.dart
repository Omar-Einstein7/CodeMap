import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/services/service_locator.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/section.dart';
import '../../domain/entities/lesson.dart';
import '../cubit/course_detail_cubit.dart';
import '../cubit/course_detail_state.dart';
import '../cubit/lesson_progress_cubit.dart';
import '../cubit/lesson_progress_state.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<CourseDetailCubit>()..loadCourseDetails(course.id),
        ),
        BlocProvider(
          create: (context) =>
              sl<LessonProgressCubit>()
                ..loadProgress('mock_user_id', course.id),
        ),
      ],
      child: const CourseDetailView(),
    );
  }
}

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        // Use the initial course data while loading details
        // Or if loaded, use the full details
        final Course displayCourse = state is CourseDetailLoaded
            ? state.course
            : (context
                      .findAncestorWidgetOfExactType<CourseDetailScreen>()
                      ?.course ??
                  Course(
                    id: '',
                    name: '',
                    imageUrl: '',
                    category: CourseCategory.ai,
                  )); // Fallback

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // 1. SliverAppBar with Course Image
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                stretch: true,
                backgroundColor: theme.primaryColor,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'course_image_${displayCourse.id}',
                        child: Image.asset(
                          displayCourse.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black26,
                              Colors.transparent,
                              Colors.black54,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    displayCourse.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // 2. Loading Indicator or Error
              if (state is CourseDetailLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is CourseDetailError)
                SliverFillRemaining(
                  child: Center(child: Text('Error: ${state.message}')),
                )
              else if (state is CourseDetailLoaded) ...[
                // 3. Course Metadata (Title, Desc, Progress)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayCourse.description ??
                              'No description available.',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        _buildProgressSection(context),
                      ],
                    ),
                  ),
                ),

                // 4. Sections List (Hierarchy)
                if (state.course.sections.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text("No content available yet.")),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final section = state.course.sections[index];
                      return _buildSectionItem(
                        context,
                        section,
                        displayCourse.id,
                      );
                    }, childCount: state.course.sections.length),
                  ),

                // Bottom padding
                const SliverPadding(padding: EdgeInsets.only(bottom: 50)),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return BlocBuilder<LessonProgressCubit, LessonProgressState>(
      builder: (context, state) {
        if (state is LessonProgressLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Progress",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${(state.progress.percentComplete * 100).toInt()}%"),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: state.progress.percentComplete,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          );
        }
        return const SizedBox.shrink(); // Hide if loading or error
      },
    );
  }

  Widget _buildSectionItem(
    BuildContext context,
    Section section,
    String courseId,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          width: double.infinity,
          child: Text(
            section.title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.0,
              fontSize: 12,
            ),
          ),
        ),

        // Lessons in this section
        ...section.lessons.map(
          (lesson) => _buildLessonItem(context, lesson, courseId),
        ),
      ],
    );
  }

  Widget _buildLessonItem(
    BuildContext context,
    Lesson lesson,
    String courseId,
  ) {
    return BlocBuilder<LessonProgressCubit, LessonProgressState>(
      builder: (context, state) {
        final isCompleted =
            state is LessonProgressLoaded && state.isCompleted(lesson.id);

        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : _getLessonIcon(lesson),
              color: isCompleted ? Colors.green : Colors.grey,
              size: 20,
            ),
          ),
          title: Text(
            lesson.title,
            style: TextStyle(
              fontWeight: isCompleted ? FontWeight.normal : FontWeight.w500,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              color: isCompleted ? Colors.grey : null,
            ),
          ),
          subtitle: Text(
            "${lesson.estimatedDuration.inMinutes} min • ${_getLessonTypeLabel(lesson)}",
            style: const TextStyle(fontSize: 12),
          ),
          trailing: lesson.isPreview
              ? const Chip(
                  label: Text("Free", style: TextStyle(fontSize: 10)),
                  visualDensity: VisualDensity.compact,
                )
              : null,
          onTap: () {
            // Optimistic completion toggle for demo purposes
            if (!isCompleted) {
              context.read<LessonProgressCubit>().completeLesson(
                'mock_user_id',
                courseId,
                lesson.id,
              );
            }

            // Navigate to content player (Video/Text/Quiz)
            // Navigator.push(...);
          },
        );
      },
    );
  }

  IconData _getLessonIcon(Lesson lesson) {
    return switch (lesson) {
      VideoLesson() => Icons.play_arrow,
      TextLesson() => Icons.article,
      QuizLesson() => Icons.quiz,
    };
  }

  String _getLessonTypeLabel(Lesson lesson) {
    return switch (lesson) {
      VideoLesson() => "Video",
      TextLesson() => "Article",
      QuizLesson() => "Quiz",
    };
  }
}
