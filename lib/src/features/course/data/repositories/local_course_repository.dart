import '../../domain/entities/course.dart';
import '../../domain/entities/section.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/repositories/course_repository.dart';

class LocalCourseRepository implements CourseRepository {
  // Simulating local data
  final List<Course> _allCourses = [
    Course(
      id: '1',
      name: "C#",
      imageUrl: "images2/1C#.jpeg",
      category: CourseCategory.mobile,
    ),
    Course(
      id: '2',
      name: "C++",
      imageUrl: "images2/2C++.jpeg",
      category: CourseCategory.mobile,
    ),
    Course(
      id: '3',
      name: "CSS",
      imageUrl: "images2/3Css.jpeg",
      category: CourseCategory.frontend,
    ),
    Course(
      id: '4',
      name: "HTML",
      imageUrl: "images2/html-5.png",
      category: CourseCategory.frontend,
    ),
    Course(
      id: '5',
      name: "Java",
      imageUrl: "images2/5Java.png",
      category: CourseCategory.backend,
    ),
    Course(
      id: '6',
      name: "JS",
      imageUrl: "images2/6Javascript.png",
      category: CourseCategory.backend,
    ),
    Course(
      id: '7',
      name: "Python",
      imageUrl: "images2/7Python.png",
      category: CourseCategory.ai,
    ),

    // Adding more for other categories for demonstration
    Course(
      id: '8',
      name: "Flutter",
      imageUrl: "mobile/Flutter.png",
      category: CourseCategory.mobile,
    ),
    Course(
      id: '9',
      name: "React Native",
      imageUrl: "mobile/Flutter.png",
      category: CourseCategory.mobile,
    ),

    Course(
      id: '10',
      name: "React",
      imageUrl: "images2/6Javascript.png",
      category: CourseCategory.frontend,
    ),
    Course(
      id: '11',
      name: "Vue",
      imageUrl: "images2/6Javascript.png",
      category: CourseCategory.frontend,
    ),

    Course(
      id: '12',
      name: "Node.js",
      imageUrl: "images2/6Javascript.png",
      category: CourseCategory.backend,
    ),
    Course(
      id: '13',
      name: "Django",
      imageUrl: "images2/7Python.png",
      category: CourseCategory.backend,
    ),

    Course(
      id: '14',
      name: "Windows App",
      imageUrl: "images2/1C#.jpeg",
      category: CourseCategory.desktop,
    ),
    Course(
      id: '15',
      name: "MacOS App",
      imageUrl: "images2/1C#.jpeg",
      category: CourseCategory.desktop,
    ),
  ];

  @override
  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ['Recent', 'mobile', 'frontend', 'backend', 'AI', 'games'];
  }

  @override
  Future<List<Course>> getFeaturedCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _allCourses.take(7).toList();
  }

  @override
  Future<List<Course>> getCoursesByCategory(CourseCategory category) async {
    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _allCourses.where((c) => c.category == category).toList();
  }

  @override
  Future<List<Course>> searchCourses(
    String query,
    CourseCategory category,
  ) async {
    final courses = await getCoursesByCategory(category);
    if (query.isEmpty) return courses;
    return courses
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Course>> globalSearch(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) return [];
    return _allCourses
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<Course> getCourseDetails(String courseId) async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulating network delay

    final course = _allCourses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => throw Exception('Course not found'),
    );

    // Mocking rich content structure for the Flutter course (ID 8)
    // In a real app, this would come from an API
    if (courseId == '8') {
      return Course(
        id: course.id,
        name: course.name,
        imageUrl: course.imageUrl,
        category: course.category,
        description:
            "Master Flutter 3.x and Dart 3.x with this comprehensive course.",
        sections: [
          Section(
            id: 's1',
            title: 'Getting Started',
            orderIndex: 0,
            lessons: [
              const VideoLesson(
                id: 'l1',
                title: 'Introduction to Flutter',
                sectionId: 's1',
                estimatedDuration: Duration(minutes: 5),
                videoUrl: 'https://example.com/intro.mp4',
                isPreview: true,
              ),
              const TextLesson(
                id: 'l2',
                title: 'Installation Guide',
                sectionId: 's1',
                estimatedDuration: Duration(minutes: 10),
                markdownContent: '# How to install Flutter...',
              ),
            ],
          ),
          Section(
            id: 's2',
            title: 'Dart Basics',
            orderIndex: 1,
            lessons: [
              const VideoLesson(
                id: 'l3',
                title: 'Variables & Data Types',
                sectionId: 's2',
                estimatedDuration: Duration(minutes: 15),
                videoUrl: 'https://example.com/dart_basics.mp4',
              ),
              const QuizLesson(
                id: 'l4',
                title: 'Dart Basics Quiz',
                sectionId: 's2',
                estimatedDuration: Duration(minutes: 5),
                questions: [
                  QuizQuestion(
                    id: 'q1',
                    text: 'Which keyword is used for immutable variables?',
                    options: ['var', 'final', 'const', 'let'],
                    correctOptionIndex: 2,
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    // Return empty sections for other courses for now
    return course;
  }
}
