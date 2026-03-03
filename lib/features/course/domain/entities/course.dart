enum CourseCategory {
  mobile,
  frontend,
  backend,
  ai,
  desktop;

  String get displayName {
    switch (this) {
      case CourseCategory.mobile:
        return 'Mobile';
      case CourseCategory.frontend:
        return 'Frontend';
      case CourseCategory.backend:
        return 'Backend';
      case CourseCategory.ai:
        return 'AI';
      case CourseCategory.desktop:
        return 'Desktop';
    }
  }
}

class Course {
  final String id;
  final String name;
  final String imageUrl;
  final CourseCategory category;
  final String? description;

  Course({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    this.description,
  });
}
