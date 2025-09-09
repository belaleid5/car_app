import 'package:car_app/core/error/faliure.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Exception exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const NetworkException('Connection timeout. Please check your internet connection.');
        break;

      case DioExceptionType.connectionError:
        exception = const NetworkException('No internet connection. Please check your network settings.');
        break;

      case DioExceptionType.badResponse:
        exception = _handleResponseError(err);
        break;

      case DioExceptionType.cancel:
        exception = const NetworkException('Request was cancelled.');
        break;

      case DioExceptionType.unknown:
        exception = NetworkException('Unknown error occurred: ${err.message}');
        break;

      default:
        exception = NetworkException('Unexpected error: ${err.message}');
    }

    // Create a new DioException with our custom message
    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: exception,
      message: _getExceptionMessage(exception),
    );

    handler.next(customError);
  }

  Exception _handleResponseError(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    String message = 'Server error occurred';

    if (data is Map<String, dynamic>) {
      message = data['message'] ?? data['error'] ?? message;
    }

    switch (statusCode) {
      case 400:
        return ValidationException(message);
      case 401:
        return AuthException('Authentication failed. Please login again.');
      case 403:
        return AuthException('Access denied. You don\'t have permission to perform this action.');
      case 404:
        return ServerException('Requested resource not found.', statusCode);
      case 422:
        return ValidationException(_extractValidationErrors(data));
      case 429:
        return ServerException('Too many requests. Please try again later.', statusCode);
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException('Server is currently unavailable. Please try again later.', statusCode);
      default:
        return ServerException(message, statusCode);
    }
  }

  String _extractValidationErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data.containsKey('errors') && data['errors'] is Map) {
        final errors = data['errors'] as Map<String, dynamic>;
        final errorMessages = <String>[];
        
        errors.forEach((field, messages) {
          if (messages is List) {
            errorMessages.addAll(messages.cast<String>());
          } else {
            errorMessages.add(messages.toString());
          }
        });
        
        return errorMessages.join('\n');
      }
      
      return data['message'] ?? 'Validation failed';
    }
    
    return 'Validation failed';
  }

  String _getExceptionMessage(Exception exception) {
    if (exception is NetworkException) return exception.message;
    if (exception is ServerException) return exception.message;
    if (exception is ValidationException) return exception.message;
    if (exception is AuthException) return exception.message;
    return exception.toString();
  }
}