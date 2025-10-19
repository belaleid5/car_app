import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/features/cars_feature/car_details/data/model/pagenated_reivw_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/cars_model.dart';
import 'package:dio/dio.dart';

abstract class ReviewRemoteDataSource {
  Future<PaginatedReviewsModel> getReviewsByCarId({
    required int carId,
    int page = 1,
    int perPage = 5,
  });
  Future<CarModel> getCarById(int carId);
  Future<PaginatedReviewsModel> getUsersCarReviews(int carId, int page);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
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
        return PaginatedReviewsModel.fromJson(response.data);
      } else {
        throw ServerException('فشل في جلب التقييمات');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    }
  }

  @override
  Future<CarModel> getCarById(int carId) async {
    try {
      final response = await sl<DioClient>().dio.get(
        'https://qent.up.railway.app/api/cars/$carId',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final carJson = data is Map<String, dynamic> && data.containsKey('data')
            ? data['data']
            : data;
        return CarModel.fromJson(carJson);
      } else {
        throw ServerException('فشل في تحميل تفاصيل السيارة');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Future<PaginatedReviewsModel> getUsersCarReviews(int carId, int page) async {
    try {
      final response = await sl<DioClient>().dio.get(
        'https://qent.up.railway.app/api/cars/$carId/reviews',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        return PaginatedReviewsModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException(
          'خطأ في السيرفر: رمز الحالة ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // 🧰 معالجة الأخطاء الموحدة
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';
      case DioExceptionType.badResponse:
        return error.response?.data['message'] ?? 'حدث خطأ في السيرفر';
      case DioExceptionType.cancel:
        return 'تم إلغاء الطلب';
      case DioExceptionType.connectionError:
        return 'خطأ في الاتصال. تحقق من الإنترنت.';
      default:
        return 'حدث خطأ غير متوقع';
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException('انتهت مهلة الاتصال بالسيرفر');
      case DioExceptionType.sendTimeout:
        return NetworkException('انتهت مهلة إرسال البيانات');
      case DioExceptionType.receiveTimeout:
        return NetworkException('انتهت مهلة استقبال البيانات');
      case DioExceptionType.badResponse:
        return _handleBadResponse(e.response);
      case DioExceptionType.cancel:
        return NetworkException('تم إلغاء الطلب');
      case DioExceptionType.connectionError:
        return NetworkException('لا يوجد اتصال بالإنترنت');
      case DioExceptionType.badCertificate:
        return NetworkException('مشكلة في شهادة الأمان');
      case DioExceptionType.unknown:
        if (e.message?.contains('SocketException') ?? false) {
          return NetworkException('لا يوجد اتصال بالإنترنت');
        }
        return ServerException('خطأ غير معروف: ${e.message}');
    }
  }

  Exception _handleBadResponse(Response? response) {
    if (response == null) {
      return ServerException('لم يتم استلام رد من السيرفر');
    }

    switch (response.statusCode) {
      case 400:
        return ServerException('طلب غير صحيح');
      case 401:
        return ServerException('غير مصرح لك بالوصول');
      case 403:
        return ServerException('محظور الوصول');
      case 404:
        return ServerException('الصفحة المطلوبة غير موجودة');
      case 500:
        return ServerException('خطأ داخلي في السيرفر');
      case 503:
        return ServerException('الخدمة غير متاحة حالياً');
      default:
        return ServerException(
          'خطأ في السيرفر: رمز الحالة ${response.statusCode}',
        );
    }
  }
}
