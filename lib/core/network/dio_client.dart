import 'package:car_app/core/network/auth_interceptor.dart';
import 'package:car_app/core/network/inceptores/error_inceptors.dart';
import 'package:car_app/core/network/inceptores/loggin_inceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';


class DioClient {
  static DioClient? _instance;
  late Dio _dio;

  DioClient._internal() {
    _dio = Dio();
    _setupInterceptors();
    _setupBaseOptions();
  }

  static DioClient get instance {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  Dio get dio => _dio;

  void _setupBaseOptions() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
      followRedirects: true,
      maxRedirects: 3,
    );
  }

  void _setupInterceptors() {
    // Add interceptors in order of execution
    _dio.interceptors.addAll([
      // Custom error interceptor (first to catch all errors)
      ErrorInterceptor(),
      
      // Auth interceptor for token management
      AuthInterceptor(),
      
      // Logging interceptor (last to log everything)
      if (kDebugMode) LoggingInterceptor(),
    ]);
  }

  // Method to update base URL if needed
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }

  // Method to add custom headers
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  // Method to remove headers
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  // Method to clear all custom headers
  void clearHeaders() {
    _dio.options.headers.clear();
    _dio.options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
  }
}