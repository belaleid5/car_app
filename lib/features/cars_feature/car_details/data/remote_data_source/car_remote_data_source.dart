
import 'package:car_app/core/constants/api_constants.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/features/cars_feature/home/data/model/cars_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/reivew_model.dart';
import 'package:dio/dio.dart';

abstract class CarRemoteDataSource {
  Future<List<CarModel>> getAllCars({required int page, required int limit});
  Future<CarModel> getCarById(int carId);
  Future<List<CarModel>> searchCars(String query);
  Future<List<CarModel>> getCarsByBrand(int brandId);
  Future<ReviewModel> getCarsReview(int carId);
}





class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final DioClient dio;

  CarRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<CarModel>> getAllCars({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.dio.get(
                'https://qent.up.railway.app/api/cars',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data.map((json) => CarModel.fromJson(json)).toList();
      } else {
        throw ServerException('فشل في تحميل السيارات');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Future<CarModel> getCarById(int carId) async {
    try {
      final response = await dio.dio.get('https://qent.up.railway.app/api/cars/$carId');

      if (response.statusCode == 200) {
        return CarModel.fromJson(response.data['data'] ?? response.data);
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
  Future<List<CarModel>> searchCars(String query) async {
    try {
      final response = await dio.dio.get(
        'https://qent.up.railway.app/api/cars/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data.map((json) => CarModel.fromJson(json)).toList();
      } else {
        throw ServerException('فشل في البحث');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Future<List<CarModel>> getCarsByBrand(int brandId) async {
    try {
      final response = await dio.dio.get(
        'https://qent.up.railway.app/api/brands/$brandId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data.map((json) => CarModel.fromJson(json)).toList();
      } else {
        throw ServerException('فشل في تحميل سيارات البراند');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }

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
  
  @override
  Future<ReviewModel> getCarsReview(int carId) async {
    try {
      final response = await dio.dio.get(
        ApiConstants.reviewsEndpoint,
        queryParameters: {'carId': carId},
      );

      if (response.statusCode == 200) {
        final  data = response.data['data'] ?? response.data;
        return data.map((json) => ReviewModel.fromJson(json)).toList();
      } else {
        throw ServerException('فشل في تحميل المراجعات');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع: $e');
    }
  }
}