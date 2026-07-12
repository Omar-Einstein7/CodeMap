import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class FeaturedCoursesList extends StatelessWidget {
  final List<String> courses;
  final List<String> images;

  const FeaturedCoursesList({
    Key? key,
    required this.courses,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.32,
      child: ListView.builder(
        itemCount: courses.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.45,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.glassDark
                  : AppColors.glassLight,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isDark
                    ? AppColors.glassBorderDark
                    : AppColors.glassBorderLight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.04)
                          : Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    child: Image.asset(images[index], fit: BoxFit.contain),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Text(
                      courses[index],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
