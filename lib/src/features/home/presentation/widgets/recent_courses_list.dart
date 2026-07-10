import 'package:flutter/material.dart';

class RecentCoursesList extends StatelessWidget {
  final List<String> courses;
  final List<String> images;

  const RecentCoursesList({
    Key? key,
    required this.courses,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: courses.length > 5 ? 5 : courses.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isLight ? Colors.white : const Color(0xFF333333),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isLight ? Colors.grey[50] : const Color(0xFF3D3D3D),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(images[index], fit: BoxFit.contain),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courses[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isLight ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ELZERO WEB SCHOOL",
                      style: TextStyle(
                        fontSize: 12,
                        color: isLight ? Colors.grey[600] : Colors.grey[400],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        );
      },
    );
  }
}
