import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/theme/app_theme.dart';
import 'package:codemap2/src/shared/widgets/widgets.dart';
import '../../domain/entities/course.dart';
import '../widgets/category_card.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: GlassBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: theme.colorScheme.primary,
                ),
                child: const Text(
                  "C O U R S E S",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: CourseCategory.values.length,
                  itemBuilder: (context, index) {
                    final category = CourseCategory.values[index];
                    return CategoryCard(
                      category: category,
                      onTap: () {
                        context.push('/courses/${category.name}');
                      },
                    );
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
