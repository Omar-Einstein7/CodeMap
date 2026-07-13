import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/theme/app_theme.dart';
import 'package:codemap2/src/shared/widgets/widgets.dart';
import '../../domain/entities/course.dart';

class CourseContentScreen extends StatelessWidget {
  final Course course;

  const CourseContentScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, String>> videos = [
      {"title": "01 - Introduction to ${course.name}", "duration": "05:20"},
      {"title": "02 - Setting up the Environment", "duration": "12:45"},
      {"title": "03 - Basic Concepts & Fundamentals", "duration": "25:10"},
      {"title": "04 - Building Your First Project", "duration": "45:30"},
      {"title": "05 - Advanced Techniques", "duration": "38:15"},
      {"title": "06 - State Management Overview", "duration": "22:00"},
      {"title": "07 - Final Project & Wrap-up", "duration": "15:40"},
    ];

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          course.name,
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
                  Image.asset(
                    course.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    opacity: const AlwaysStoppedAnimation(0.5),
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
                  "${videos.length} Lessons",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                final bool isSelected = index == 0;

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
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.textTertiaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
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
                      video["title"]!,
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
                      video["duration"]!,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.textTertiaryColor,
                      ),
                    ),
                    trailing: Icon(
                      isSelected ? Icons.play_arrow_rounded : Icons.lock_outline_rounded,
                      color: isSelected ? theme.colorScheme.primary : theme.textTertiaryColor,
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
