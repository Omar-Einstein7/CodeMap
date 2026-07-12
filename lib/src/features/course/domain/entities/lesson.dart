import 'package:equatable/equatable.dart';

enum LessonType { video, text, quiz }

/// Represents the atomic unit of learning content.
/// Using Dart 3 sealed class for exhaustive pattern matching.
sealed class Lesson extends Equatable {
  final String id;
  final String title;
  final String sectionId;
  final Duration estimatedDuration;
  final bool isPreview; // Can be viewed without entitlement

  const Lesson({
    required this.id,
    required this.title,
    required this.sectionId,
    required this.estimatedDuration,
    this.isPreview = false,
  });

  @override
  List<Object?> get props => [id, title, sectionId, estimatedDuration, isPreview];
}

class VideoLesson extends Lesson {
  final String videoUrl;
  final String? transcript;
  final String? thumbnailUrl;

  const VideoLesson({
    required super.id,
    required super.title,
    required super.sectionId,
    required super.estimatedDuration,
    required this.videoUrl,
    this.transcript,
    this.thumbnailUrl,
    super.isPreview,
  });

  @override
  List<Object?> get props => [...super.props, videoUrl, transcript, thumbnailUrl];
}

class TextLesson extends Lesson {
  final String markdownContent;
  final List<String>? resourceUrls;

  const TextLesson({
    required super.id,
    required super.title,
    required super.sectionId,
    required super.estimatedDuration,
    required this.markdownContent,
    this.resourceUrls,
    super.isPreview,
  });

  @override
  List<Object?> get props => [...super.props, markdownContent, resourceUrls];
}

class QuizLesson extends Lesson {
  final List<QuizQuestion> questions;
  final int passingScore;

  const QuizLesson({
    required super.id,
    required super.title,
    required super.sectionId,
    required super.estimatedDuration,
    required this.questions,
    this.passingScore = 70, // Default 70%
    super.isPreview,
  });

  @override
  List<Object?> get props => [...super.props, questions, passingScore];
}

/// Helper entity for Quiz Questions
class QuizQuestion extends Equatable {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String? explanation;

  const QuizQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
  });

  @override
  List<Object?> get props => [id, text, options, correctOptionIndex, explanation];
}
