import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIUrls {
  static String get baseURL => dotenv.env['API_BASE_URL'] ?? 'https://codemap2-001-site1.ctempurl.com';
}