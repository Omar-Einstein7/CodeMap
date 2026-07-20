import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/services/service_locator.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/services/session_state.dart';
import 'package:codemap2/src/theme/app_theme.dart';
import 'package:codemap2/src/shared/widgets/widgets.dart';
import '../../domain/entities/course.dart';
import '../cubit/course_detail_cubit.dart';
import '../cubit/course_detail_state.dart';
import '../cubit/lesson_progress_cubit.dart';
import '../cubit/lesson_progress_state.dart';

class CourseContentScreen extends StatelessWidget {
  final Course course;

  const CourseContentScreen({super.key, required this.course});

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
              sl<LessonProgressCubit>()..loadProgress(uid, course.id),
        ),
      ],
      child: CourseContentView(course: course),
    );
  }
}

class CourseContentView extends StatelessWidget {
  final Course course;

  const CourseContentView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        final displayCourse = state is CourseDetailLoaded
            ? state.course
            : course;

        final allLessons = displayCourse.sections
            .expand((s) => s.lessons)
            .toList();
        final totalLessons = allLessons.length;

        return GlassScaffold(
          appBar: AppBar(
            title: Text(
              displayCourse.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            leading: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => context.pop(),
            ),
          ),
          body: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CourseImage(
                        imageUrl: displayCourse.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "PREVIEW",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.success.withValues(alpha: 0.1),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppColors.success),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Successfully enrolled as Free! Enjoy your course.",
                        style: TextStyle(
                          color: isDark
                              ? AppColors.success.withValues(alpha: 0.8)
                              : AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Course Content",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.textPrimaryColor,
                      ),
                    ),
                    Text(
                      "$totalLessons Lessons",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              if (state is CourseDetailLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (totalLessons == 0)
                Expanded(
                  child: Center(
                    child: Text(
                      "No content available yet.",
                      style: TextStyle(color: theme.textSecondaryColor),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: totalLessons,
                    itemBuilder: (context, index) {
                      final lesson = allLessons[index];
                      final isSelected = index == 0;

                      return BlocBuilder<LessonProgressCubit, LessonProgressState>(
                        builder: (context, progressState) {
                          final isCompleted = progressState is LessonProgressLoaded &&
                              progressState.isCompleted(lesson.id);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.primary.withValues(alpha: 0.12)
                                  : theme.glassColor,
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected
                                  ? Border.all(
                                      color: theme.colorScheme.primary.withValues(alpha: 0.3))
                                  : Border.all(color: theme.glassBorder),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: isCompleted
                                      ? AppColors.success
                                      : (isSelected
                                          ? theme.colorScheme.primary
                                          : theme.textTertiaryColor),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: isCompleted
                                      ? const Icon(Icons.check_rounded,
                                          color: Colors.white, size: 18)
                                      : Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                ),
                              ),
                              title: Text(
                                lesson.title,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.textPrimaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                "${lesson.estimatedDuration.inMinutes} min",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.textTertiaryColor,
                                ),
                              ),
                              trailing: Icon(
                                isCompleted
                                    ? Icons.check_circle_rounded
                                    : (lesson.isPreview
                                        ? Icons.play_circle_outline_rounded
                                        : Icons.lock_outline_rounded),
                                color: isCompleted
                                    ? AppColors.success
                                    : (isSelected
                                        ? theme.colorScheme.primary
                                        : theme.textTertiaryColor),
                              ),
                              onTap: () {
                                if (!isCompleted && lesson.isPreview) {
                                  // Play preview
                                } else if (!isCompleted) {
                                  context.read<LessonProgressCubit>().completeLesson(
                                    CourseContentScreen.userId(context),
                                    displayCourse.id,
                                    lesson.id,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
