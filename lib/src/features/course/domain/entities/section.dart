import 'package:equatable/equatable.dart';
import 'lesson.dart';

/// Represents a thematic group of lessons (e.g., "Chapter 1: Basics").
class Section extends Equatable {
  final String id;
  final String title;
  final String? description;
  final int orderIndex; // For sorting
  final List<Lesson> lessons;

  const Section({
    required this.id,
    required this.title,
    this.description,
    required this.orderIndex,
    required this.lessons,
  });

  /// Helper to get total duration of the section
  Duration get totalDuration {
    return lessons.fold(Duration.zero, (prev, curr) => prev + curr.estimatedDuration);
  }
  
  /// Helper to get lesson count
  int get lessonCount => lessons.length;

  @override
  List<Object?> get props => [id, title, description, orderIndex, lessons];
}
