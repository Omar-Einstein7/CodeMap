import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';

class LocalCourseRepository implements CourseRepository {
  // Simulating local data
  final List<Course> _allCourses = [
    Course(id: '1', name: "C#", imageUrl: "images2/1C#.jpeg", category: CourseCategory.ai),
    Course(id: '2', name: "C++", imageUrl: "images2/2C++.jpeg", category: CourseCategory.ai),
    Course(id: '3', name: "CSS", imageUrl: "images2/3Css.jpeg", category: CourseCategory.ai),
    Course(id: '4', name: "HTML", imageUrl: "images2/html-5.png", category: CourseCategory.ai),
    Course(id: '5', name: "Java", imageUrl: "images2/5Java.png", category: CourseCategory.ai),
    Course(id: '6', name: "JS", imageUrl: "images2/6Javascript.png", category: CourseCategory.ai),
    Course(id: '7', name: "Python", imageUrl: "images2/7Python.png", category: CourseCategory.ai),
    
    // Adding more for other categories for demonstration
    Course(id: '8', name: "Flutter", imageUrl: "mobile/Flutter.png", category: CourseCategory.mobile),
    Course(id: '9', name: "React Native", imageUrl: "mobile/Flutter.png", category: CourseCategory.mobile),
    
    Course(id: '10', name: "React", imageUrl: "images2/6Javascript.png", category: CourseCategory.frontend),
    Course(id: '11', name: "Vue", imageUrl: "images2/6Javascript.png", category: CourseCategory.frontend),
    
    Course(id: '12', name: "Node.js", imageUrl: "images2/6Javascript.png", category: CourseCategory.backend),
    Course(id: '13', name: "Django", imageUrl: "images2/7Python.png", category: CourseCategory.backend),
    
    Course(id: '14', name: "Windows App", imageUrl: "images2/1C#.jpeg", category: CourseCategory.desktop),
    Course(id: '15', name: "MacOS App", imageUrl: "images2/1C#.jpeg", category: CourseCategory.desktop),
  ];

  @override
  Future<List<Course>> getCoursesByCategory(CourseCategory category) async {
    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _allCourses.where((c) => c.category == category).toList();
  }

  @override
  Future<List<Course>> searchCourses(String query, CourseCategory category) async {
    final courses = await getCoursesByCategory(category);
    if (query.isEmpty) return courses;
    return courses.where((c) => c.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
