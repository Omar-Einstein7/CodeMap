import 'package:equatable/equatable.dart';
import 'section.dart';

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

class Course extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final CourseCategory category;
  final String? description;
  final List<Section> sections; // Hierarchy Root
  final bool isPremium; // For monetization gating

  const Course({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    this.description,
    this.sections = const [], // Default to empty for list views
    this.isPremium = false,
  });

  /// Helper to calculate total course duration
  Duration get totalDuration {
    return sections.fold(Duration.zero, (prev, curr) => prev + curr.totalDuration);
  }

  /// Helper to get total lesson count
  int get totalLessons {
    return sections.fold(0, (prev, curr) => prev + curr.lessonCount);
  }

  @override
  List<Object?> get props => [id, name, imageUrl, category, description, sections, isPremium];
}
