import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codemap2/src/features/course/domain/entities/course.dart';

class RecentCoursesService {
  final SharedPreferences _prefs;
  static const _key = 'recent_courses';
  static const _maxCourses = 10;

  final StreamController<List<Course>> _controller =
      StreamController<List<Course>>.broadcast();

  RecentCoursesService(this._prefs);

  Stream<List<Course>> get recentCoursesStream => _controller.stream;

  Future<void> addCourse(Course course) async {
    final list = await _getRawList();
    list.removeWhere((c) => c['id'] == course.id);
    list.insert(0, _serialize(course));
    if (list.length > _maxCourses) list.removeLast();
    await _prefs.setString(_key, jsonEncode(list));
    _controller.add(list.map(_deserialize).toList());
  }

  Future<List<Course>> getRecentCourses() async {
    final list = await _getRawList();
    return list.map(_deserialize).toList();
  }

  void dispose() {
    _controller.close();
  }

  Future<List<Map<String, dynamic>>> _getRawList() async {
    final raw = _prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw);
    if (decoded is List) return decoded.cast<Map<String, dynamic>>();
    return [];
  }

  Map<String, dynamic> _serialize(Course c) => {
        'id': c.id,
        'name': c.name,
        'imageUrl': c.imageUrl,
        'category': c.category.name,
      };

  Course _deserialize(Map<String, dynamic> m) => Course(
        id: m['id'] as String,
        name: m['name'] as String,
        imageUrl: m['imageUrl'] as String,
        category: CourseCategory.values.firstWhere(
          (c) => c.name == m['category'],
          orElse: () => CourseCategory.mobile,
        ),
      );
}
