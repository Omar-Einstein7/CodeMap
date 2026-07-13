import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIUrls {
  static String get baseURL {
    final webBaseUrl = dotenv.env['API_WEB_BASE_URL']?.trim();
    if (kIsWeb && webBaseUrl != null && webBaseUrl.isNotEmpty) {
      return webBaseUrl;
    }

    final baseUrl = dotenv.env['API_BASE_URL']?.trim();
    if (baseUrl != null && baseUrl.isNotEmpty) return baseUrl;

    return 'http://192.168.1.5:5000';
  }

  static const String login = '/api/auth/login';
  static const String signup = '/api/auth/signup';
  static const String me = '/api/auth/me';
  static const String logout = '/api/auth/logout';
  static const String resetPassword = '/api/auth/reset-password';
  static const String verifyCode = '/api/auth/verify-code';
  static const String newPassword = '/api/auth/new-password';

  static const String featuredCourses = '/api/courses/featured';
  static const String categories = '/api/courses/categories';
  static const String searchCourses = '/api/courses/search';

  static String coursesByCategory(String category) =>
      '/api/courses/category/$category';
  static String courseDetails(String courseId) => '/api/courses/$courseId';

  static String progress(String userId, String courseId) =>
      '/api/progress/$userId/$courseId';
  static String completeLesson(
    String userId,
    String courseId,
    String lessonId,
  ) => '/api/progress/$userId/$courseId/complete/$lessonId';

  static String favourites(String userId) => '/api/favourites/$userId';
  static String addFavourite(String userId, String courseId) =>
      '/api/favourites/$userId/add/$courseId';
  static String removeFavourite(String userId, String courseId) =>
      '/api/favourites/$userId/remove/$courseId';
  static String checkFavourite(String userId, String courseId) =>
      '/api/favourites/$userId/check/$courseId';

  static String userProfile(String userId) => '/api/users/$userId/profile';
  static String enrolledCourses(String userId) => '/api/users/$userId/enrolled';
}
