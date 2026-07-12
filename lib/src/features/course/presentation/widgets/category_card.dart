import 'package:flutter/material.dart';
import '../../domain/entities/course.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class CategoryCard extends StatelessWidget {
  final CourseCategory category;
  final VoidCallback onTap;
  final Color? color;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ??
              (isDark ? AppColors.glassDark : AppColors.glassLight),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            category.displayName.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : theme.primaryColor,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
