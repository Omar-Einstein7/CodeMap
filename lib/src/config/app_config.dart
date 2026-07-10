import 'package:dio/dio.dart';
import 'api_urls.dart';

class AppConfig {
  AppConfig._();
  static late final Dio dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: APIUrls.baseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }
}
