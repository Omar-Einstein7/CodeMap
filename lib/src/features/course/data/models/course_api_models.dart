import '../../domain/entities/course.dart';
import '../../domain/entities/course_progress.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/section.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.category,
    super.description,
    super.sections,
    super.isPremium,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: (json['name'] ?? json['title'] ?? '').toString(),
      imageUrl:
          (json['imageUrl'] ??
                  json['image_url'] ??
                  json['thumbnailUrl'] ??
                  json['thumbnail'] ??
                  '')
              .toString(),
      category: _parseCategory(json['category']),
      description: (json['description'] ?? json['summary'])?.toString(),
      isPremium: json['isPremium'] == true || json['premium'] == true,
      sections: _parseSections(json['sections']),
    );
  }

  static CourseCategory _parseCategory(dynamic value) {
    final normalized = value?.toString().toLowerCase().trim();
    return CourseCategory.values.firstWhere(
      (category) => category.name == normalized,
      orElse: () => CourseCategory.mobile,
    );
  }

  static List<Section> _parseSections(dynamic value) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map((json) => SectionModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }
}

class SectionModel extends Section {
  const SectionModel({
    required super.id,
    required super.title,
    super.description,
    required super.orderIndex,
    required super.lessons,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    final id = (json['_id'] ?? json['id'] ?? '').toString();
    return SectionModel(
      id: id,
      title: (json['title'] ?? json['name'] ?? '').toString(),
      description: json['description']?.toString(),
      orderIndex: _asInt(json['orderIndex'] ?? json['order'] ?? json['index']),
      lessons: _parseLessons(json['lessons'], id),
    );
  }

  static List<Lesson> _parseLessons(dynamic value, String sectionId) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map(
          (json) =>
              LessonModel.fromJson(Map<String, dynamic>.from(json), sectionId),
        )
        .toList();
  }
}

class LessonModel {
  static Lesson fromJson(Map<String, dynamic> json, String fallbackSectionId) {
    final id = (json['_id'] ?? json['id'] ?? '').toString();
    final title = (json['title'] ?? json['name'] ?? '').toString();
    final sectionId =
        (json['sectionId'] ?? json['section_id'] ?? fallbackSectionId)
            .toString();
    final estimatedDuration = Duration(
      minutes: _asInt(
        json['estimatedDuration'] ??
            json['duration'] ??
            json['durationMinutes'],
      ),
    );
    final isPreview = json['isPreview'] == true || json['preview'] == true;
    final type = (json['type'] ?? json['lessonType'] ?? 'text')
        .toString()
        .toLowerCase();

    if (type == 'video') {
      return VideoLesson(
        id: id,
        title: title,
        sectionId: sectionId,
        estimatedDuration: estimatedDuration,
        videoUrl: (json['videoUrl'] ?? json['video_url'] ?? json['url'] ?? '')
            .toString(),
        transcript: json['transcript']?.toString(),
        thumbnailUrl: (json['thumbnailUrl'] ?? json['thumbnail_url'])
            ?.toString(),
        isPreview: isPreview,
      );
    }

    if (type == 'quiz') {
      return QuizLesson(
        id: id,
        title: title,
        sectionId: sectionId,
        estimatedDuration: estimatedDuration,
        questions: _parseQuestions(json['questions']),
        passingScore: _asInt(
          json['passingScore'] ?? json['passing_score'] ?? 70,
        ),
        isPreview: isPreview,
      );
    }

    return TextLesson(
      id: id,
      title: title,
      sectionId: sectionId,
      estimatedDuration: estimatedDuration,
      markdownContent:
          (json['markdownContent'] ?? json['markdown'] ?? json['content'] ?? '')
              .toString(),
      resourceUrls: _parseStringList(
        json['resourceUrls'] ?? json['resource_urls'],
      ),
      isPreview: isPreview,
    );
  }

  static List<QuizQuestion> _parseQuestions(dynamic value) {
    if (value is! List) return const [];
    return value.whereType<Map>().map((questionJson) {
      final json = Map<String, dynamic>.from(questionJson);
      return QuizQuestion(
        id: (json['_id'] ?? json['id'] ?? '').toString(),
        text: (json['text'] ?? json['question'] ?? '').toString(),
        options: _parseStringList(json['options']) ?? const [],
        correctOptionIndex: _asInt(
          json['correctOptionIndex'] ??
              json['correct_option_index'] ??
              json['answerIndex'],
        ),
        explanation: json['explanation']?.toString(),
      );
    }).toList();
  }
}

class CourseProgressModel extends CourseProgress {
  const CourseProgressModel({
    required super.courseId,
    required super.userId,
    super.percentComplete,
    super.lastAccessedLessonId,
    super.lastAccessedAt,
    super.lessonStatus,
  });

  factory CourseProgressModel.fromJson(Map<String, dynamic> json) {
    return CourseProgressModel(
      courseId: (json['courseId'] ?? json['course_id'] ?? json['course'] ?? '')
          .toString(),
      userId: (json['userId'] ?? json['user_id'] ?? json['user'] ?? '')
          .toString(),
      percentComplete: _asDouble(
        json['percentComplete'] ?? json['percent_complete'] ?? json['progress'],
      ),
      lastAccessedLessonId:
          (json['lastAccessedLessonId'] ?? json['last_accessed_lesson_id'])
              ?.toString(),
      lastAccessedAt: _asDateTime(
        json['lastAccessedAt'] ?? json['last_accessed_at'],
      ),
      lessonStatus: _parseLessonStatus(json),
    );
  }

  static Map<String, LessonStatus> _parseLessonStatus(
    Map<String, dynamic> json,
  ) {
    final status = <String, LessonStatus>{};
    final statusJson = json['lessonStatus'] ?? json['lesson_status'];
    if (statusJson is Map) {
      statusJson.forEach((key, value) {
        status[key.toString()] = _parseStatus(value);
      });
    }

    final completedLessons =
        json['completedLessons'] ?? json['completed_lessons'];
    if (completedLessons is List) {
      for (final lesson in completedLessons) {
        final lessonId = lesson is Map
            ? (lesson['_id'] ?? lesson['id'])
            : lesson;
        if (lessonId != null) {
          status[lessonId.toString()] = LessonStatus.completed;
        }
      }
    }

    return status;
  }

  static LessonStatus _parseStatus(dynamic value) {
    final normalized = value.toString().toLowerCase();
    return LessonStatus.values.firstWhere(
      (status) => status.name.toLowerCase() == normalized,
      orElse: () => LessonStatus.available,
    );
  }
}

List<String>? _parseStringList(dynamic value) {
  if (value is! List) return null;
  return value.map((item) => item.toString()).toList();
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _asDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0.0;
}

DateTime? _asDateTime(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}
