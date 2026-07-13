import 'package:codemap2/src/config/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:codemap2/src/services/interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: APIUrls.baseURL,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          responseType: ResponseType.json,
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      )..interceptors.addAll([AuthorizationInterceptor(), LoggerInterceptor()]);

  Never _throwApiException(DioException error) {
    Error.throwWithStackTrace(
      ApiConnectionException.fromDioException(error),
      error.stackTrace,
    );
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (error) {
      _throwApiException(error);
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (error) {
      _throwApiException(error);
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (error) {
      _throwApiException(error);
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (error) {
      _throwApiException(error);
    }
  }
}

class ApiConnectionException implements Exception {
  final String message;

  const ApiConnectionException(this.message);

  factory ApiConnectionException.fromDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseMessage = _responseMessage(error.response?.data);

    if (statusCode != null) {
      return ApiConnectionException(
        responseMessage ?? 'API request failed with status code $statusCode.',
      );
    }

    if (kIsWeb && error.type == DioExceptionType.connectionError) {
      return ApiConnectionException(
        'Could not connect to the API at ${APIUrls.baseURL}. '
        'For Flutter Web, make sure the backend is running, the URL is reachable from the browser, '
        'the page and API both use compatible http/https, and the backend enables CORS for this app origin.',
      );
    }

    return ApiConnectionException(
      error.message ?? 'Could not connect to the API at ${APIUrls.baseURL}.',
    );
  }

  static String? _responseMessage(dynamic data) {
    if (data is Map) {
      return (data['message'] ?? data['error'])?.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }

  @override
  String toString() => message;
}
