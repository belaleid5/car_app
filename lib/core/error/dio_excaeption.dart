import 'package:dio/dio.dart';

class ErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timed out";
        case DioExceptionType.sendTimeout:
          return "Send request timed out";
        case DioExceptionType.receiveTimeout:
          return "Receive timeout";
        case DioExceptionType.badCertificate:
          return "Bad certificate";
        case DioExceptionType.badResponse:
          if (response != null) {
            return _handleBadResponse(response);
          } else {
            return "Server error without response";
          }
        case DioExceptionType.cancel:
          return "Request cancelled";
        case DioExceptionType.connectionError:
          return "Connection error, please check your internet";
        case DioExceptionType.unknown:
          return "Unknown error occurred";
      }
    } else {
      return "Unexpected error: ${error.toString()}";
    }
  }

  static String _handleBadResponse(Response response) {
    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    switch (statusCode) {
      case 400:
        return "Bad Request: ${_extractMessage(data)}";
      case 401:
        return "Unauthorized: Please login again";
      case 403:
        return "Forbidden: You do not have permission";
      case 404:
        return "Not Found: ${_extractMessage(data)}";
      case 500:
        return "Internal Server Error";
      case 503:
        return "Service Unavailable";
      default:
        return "Received invalid status code: $statusCode";
    }
  }

  static String _extractMessage(dynamic data) {
    try {
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'];
      }
      return data.toString();
    } catch (_) {
      return data.toString();
    }
  }
}
