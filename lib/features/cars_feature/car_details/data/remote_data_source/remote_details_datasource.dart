import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/features/cars_feature/car_details/data/model/pagintion_review_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/cars_model.dart';
import 'package:dio/dio.dart';

/// Remote Data Source Interface
/// يطبق Interface Segregation Principle
abstract class ReviewRemoteDataSource {
  Future<PaginatedReviewsModel> getReviewsByCarId({
    required int carId,
    int page = 1,
    int perPage = 5,
  });

  Future<CarModel> getCarById(int carId);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  /// Dependency Injection
  ReviewRemoteDataSourceImpl();

  @override
  Future<PaginatedReviewsModel> getReviewsByCarId({
    required int carId,
    int page = 1,
    int perPage = 5,
  }) async {
    try {
      final response = await sl<DioClient>().dio.get(
        "https://qent.up.railway.app/api/cars/$carId/reviews",
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        return PaginatedReviewsModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException('Failed to fetch reviews');
      }
    } on DioException catch (e) {
      throw _mapDioExceptionToServerException(e);
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<CarModel> getCarById(int carId) async {
    try {
      final response = await sl<DioClient>().dio.get('/api/cars/$carId');

      if (response.statusCode == 200) {
        final data = response.data;

        // Handle wrapped response
        final carJson = data is Map<String, dynamic> && data.containsKey('data')
            ? data['data']
            : data;

        return CarModel.fromJson(carJson as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to fetch car details');
      }
    } on DioException catch (e) {
      throw _mapDioExceptionToServerException(e);
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  /// Helper method لتحويل DioException إلى ServerException
  /// Clean Code: Extract Method Pattern
  ServerException _mapDioExceptionToServerException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException('Connection timeout');

      case DioExceptionType.badResponse:
        return _handleBadResponse(e.response);

      case DioExceptionType.cancel:
        return ServerException('Request cancelled');

      case DioExceptionType.connectionError:
        return ServerException('No internet connection');

      case DioExceptionType.badCertificate:
        return ServerException('Certificate error');

      case DioExceptionType.unknown:
        if (e.message?.contains('SocketException') ?? false) {
          return ServerException('No internet connection');
        }
        return ServerException('Unknown error: ${e.message}');
    }
  }

  /// Helper method لمعالجة Bad Response
  ServerException _handleBadResponse(Response? response) {
    if (response == null) {
      return ServerException('No response from server');
    }

    final statusCode = response.statusCode ?? 0;
    final message = _extractErrorMessage(response.data);

    return ServerException(_getErrorMessageByStatusCode(statusCode, message));
  }

  /// Extract error message from response
  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String?;
    }
    return null;
  }

  /// Get error message by status code
  String _getErrorMessageByStatusCode(int statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return message ?? 'Bad request';
      case 401:
        return message ?? 'Unauthorized';
      case 403:
        return message ?? 'Forbidden';
      case 404:
        return message ?? 'Not found';
      case 500:
        return message ?? 'Internal server error';
      case 503:
        return message ?? 'Service unavailable';
      default:
        return message ?? 'Server error: $statusCode';
    }
  }
}
