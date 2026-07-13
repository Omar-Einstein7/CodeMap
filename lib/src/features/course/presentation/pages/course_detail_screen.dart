import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/services/service_locator.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/services/session_state.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/section.dart';
import '../../domain/entities/lesson.dart';
import '../cubit/course_detail_cubit.dart';
import '../cubit/course_detail_state.dart';
import '../cubit/lesson_progress_cubit.dart';
import '../cubit/lesson_progress_state.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  static String userId(BuildContext context) {
    final session = context.read<SessionCubit>().state;
    if (session is SessionAuthenticated) return session.user.id;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final uid = userId(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<CourseDetailCubit>()..loadCourseDetails(course.id),
        ),
        BlocProvider(
          create: (context) =>
              sl<LessonProgressCubit>()
                ..loadProgress(uid, course.id),
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
    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
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
                  ));

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                stretch: true,
                backgroundColor: theme.colorScheme.primary,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
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

              if (state is CourseDetailLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is CourseDetailError)
                SliverFillRemaining(
                  child: Center(child: Text('Error: ${state.message}')),
                )
              else if (state is CourseDetailLoaded) ...[
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

                const SliverPadding(padding: EdgeInsets.only(bottom: 50)),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    final theme = Theme.of(context);
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
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${(state.progress.percentComplete * 100).toInt()}%",
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: state.progress.percentComplete,
                  backgroundColor: theme.glassColor,
                  color: AppColors.success,
                  minHeight: 8,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSectionItem(
    BuildContext context,
    Section section,
    String courseId,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: theme.colorScheme.primary.withValues(alpha: 0.06),
          width: double.infinity,
          child: Text(
            section.title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              letterSpacing: 1.0,
              fontSize: 12,
            ),
          ),
        ),

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
    final theme = Theme.of(context);
    return BlocBuilder<LessonProgressCubit, LessonProgressState>(
      builder: (context, state) {
        final isCompleted =
            state is LessonProgressLoaded && state.isCompleted(lesson.id);

        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.success.withValues(alpha: 0.12)
                  : theme.glassColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted
                    ? AppColors.success.withValues(alpha: 0.3)
                    : theme.glassBorder,
              ),
            ),
            child: Icon(
              isCompleted ? Icons.check_rounded : _getLessonIcon(lesson),
              color: isCompleted ? AppColors.success : theme.textTertiaryColor,
              size: 20,
            ),
          ),
          title: Text(
            lesson.title,
            style: TextStyle(
              fontWeight: isCompleted ? FontWeight.normal : FontWeight.w500,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              color: isCompleted ? theme.textTertiaryColor : theme.textPrimaryColor,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            "${lesson.estimatedDuration.inMinutes} min • ${_getLessonTypeLabel(lesson)}",
            style: TextStyle(
              fontSize: 12,
              color: theme.textTertiaryColor,
            ),
          ),
          trailing: lesson.isPreview
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Free",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                )
              : null,
          onTap: () {
            if (!isCompleted) {
              context.read<LessonProgressCubit>().completeLesson(
                CourseDetailScreen.userId(context),
                courseId,
                lesson.id,
              );
            }
          },
        );
      },
    );
  }

  IconData _getLessonIcon(Lesson lesson) {
    return switch (lesson) {
      VideoLesson() => Icons.play_arrow_rounded,
      TextLesson() => Icons.article_rounded,
      QuizLesson() => Icons.quiz_rounded,
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
