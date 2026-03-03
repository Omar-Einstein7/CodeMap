import 'package:flutter/material.dart';
import '../../domain/entities/course.dart';

class CourseContentScreen extends StatelessWidget {
  final Course course;

  const CourseContentScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Mock video list
    final List<Map<String, String>> videos = [
      {"title": "01 - Introduction to ${course.name}", "duration": "05:20"},
      {"title": "02 - Setting up the Environment", "duration": "12:45"},
      {"title": "03 - Basic Concepts & Fundamentals", "duration": "25:10"},
      {"title": "04 - Building Your First Project", "duration": "45:30"},
      {"title": "05 - Advanced Techniques", "duration": "38:15"},
      {"title": "06 - State Management Overview", "duration": "22:00"},
      {"title": "07 - Final Project & Wrap-up", "duration": "15:40"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Video Player Placeholder
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
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 80,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "PREVIEW",
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Enrollment Success Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.green.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Successfully enrolled as Free! Enjoy your course.",
                    style: TextStyle(
                      color: isDark ? Colors.green[300] : Colors.green[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Lessons Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Course Content",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${videos.length} Lessons",
                  style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // Video List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                final bool isSelected = index == 0; // Highlight first video

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected 
                      ? theme.primaryColor.withOpacity(0.1) 
                      : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected ? theme.primaryColor : Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    title: Text(
                      video["title"]!,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.primaryColor : null,
                      ),
                    ),
                    subtitle: Text(
                      video["duration"]!,
                      style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.black54),
                    ),
                    trailing: Icon(
                      isSelected ? Icons.play_arrow : Icons.lock_outline,
                      color: isSelected ? theme.primaryColor : Colors.grey,
                    ),
                    onTap: () {
                      // Handle video play
                    },
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
