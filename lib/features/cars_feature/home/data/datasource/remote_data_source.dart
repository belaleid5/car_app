import 'package:car_app/core/constants/api_constants.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/features/cars_feature/home/data/model/brands_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_response_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/cars_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/pagination_response.dart';
import 'package:dio/dio.dart';


abstract class HomeRemoteDataSource {
  Future<List<BrandModel>> getBrands({int page = 1});
  Future<CarsResponseModel> getBestCars({int page = 1}); 
  Future<CarsResponseModel> getNearestCars({required int locationId, int page = 1});



}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<BrandModel>> getBrands({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.brandsEndpoint,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final paginatedResponse = PaginatedResponse<BrandModel>.fromJson(
          response.data as Map<String, dynamic>,
          (json) => BrandModel.fromJson(json),
        );
        return paginatedResponse.data;
      } else {
        throw ServerException('فشل تحميل البراندات');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException('حدث خطأ أثناء تحميل البراندات: ${e.toString()}');
    }
  }


  @override
  Future<CarsResponseModel> getBestCars({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.bestCarsEndpoint,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        return CarsResponseModel.fromJson(response.data);
      } else {
        throw ServerException('فشل تحميل السيارات');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException('حدث خطأ أثناء تحميل السيارات: ${e.toString()}');
    }
  }

  @override
  Future<CarsResponseModel> getNearestCars({
    required int locationId,
    int page = 1,
  }) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.nearestCarsEndpoint,
        queryParameters: {
          'id': locationId,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        return CarsResponseModel.fromJson(response.data);
      } else {
        throw ServerException( 'Failed to load nearest cars');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException( e.toString());
    }
  }

  ServerException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException( 'Connection timeout');
      case DioExceptionType.badResponse:
        return ServerException(
           error.response?.data['message'] ?? 'Server error',
        );
      case DioExceptionType.cancel:
        return ServerException( 'Request cancelled');
      case DioExceptionType.connectionError:
        return ServerException( 'No internet connection');
      default:
        return ServerException( 'Unexpected error occurred');
    }
  }
  // ignore: unused_element
  String _extractErrorMessage(dynamic data) {
    if (data == null) return 'خطأ غير معروف';

    try {
      // If data is Map
      if (data is Map<String, dynamic>) {
        return data['message'] as String? ??
            data['error'] as String? ??
            data['errors'] as String? ??
            data['detail'] as String? ??
            'حدث خطأ في الخادم';
      }

      // If data is String
      if (data is String) {
        return data;
      }

      // If data is List
      if (data is List && data.isNotEmpty) {
        if (data.first is String) {
          return data.first as String;
        }
        if (data.first is Map) {
          return _extractErrorMessage(data.first);
        }
      }

      return data.toString();
    } catch (e) {
      return 'خطأ في معالجة استجابة الخادم';
    }
  }
}

class DioErrorHandler {
  static Exception handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('انقطع الاتصال بالإنترنت');

      case DioExceptionType.connectionError:
        return NetworkException('تحقق من اتصالك بالإنترنت');

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return NetworkException('تم إلغاء الطلب');

      case DioExceptionType.badCertificate:
        return NetworkException('خطأ في الشهادة الأمنية');

      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return NetworkException('لا يوجد اتصال بالإنترنت');
        }
        return NetworkException('حدث خطأ غير متوقع');

      }
  }

  static Exception _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String message = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return ValidationException('طلب غير صالح: $message');
      case 401:
        return AuthException('غير مصرح: يرجى تسجيل الدخول');
      case 403:
        return AuthException('ممنوع: تم رفض الوصول');
      case 422:
        return ValidationException('خطأ في التحقق: $message');
      case 429:
        return ServerException('طلبات كثيرة جدًا. حاول لاحقًا');
      case 500:
      case 502:
      case 503:
        return ServerException('خطأ في الخادم. حاول لاحقًا');
      default:
        return ServerException('خطأ في الخادم ($statusCode): $message');
    }
  }

  static String _extractMessage(dynamic data) {
    if (data == null) return 'خطأ غير معروف';

    try {
      if (data is Map<String, dynamic>) {
        // Try multiple possible error keys
        final message = data['message'] ??
            data['error'] ??
            data['errors'] ??
            data['detail'];

        if (message != null) {
          if (message is String) return message;
          if (message is Map) return _extractMessage(message);
          if (message is List && message.isNotEmpty) {
            return message.first.toString();
          }
        }

        // If errors is a map of field errors
        if (data['errors'] is Map) {
          final errors = data['errors'] as Map;
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
          return firstError.toString();
        }

        return 'حدث خطأ في الخادم';
      }

      if (data is String) return data;

      if (data is List && data.isNotEmpty) {
        return data.first.toString();
      }

      return data.toString();
    } catch (e) {
      return 'خطأ في معالجة الاستجابة';
    }
  }
}

