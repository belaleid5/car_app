import 'package:car_app/core/constants/api_constants.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/features/home/data/model/brands_model.dart';
import 'package:car_app/features/home/data/model/pagination_reponse-model.dart';
import 'package:dio/dio.dart';

abstract class HomeRemoteDataSource {
  Future<List<BrandModel>> getBrands({int page = 1});
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

      // Dio بيرجع الـ data parsed automatically
      final paginatedResponse = PaginatedResponse<BrandModel>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => BrandModel.fromJson(json),
      );

      return paginatedResponse.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('انقطع الاتصال بالإنترنت');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('تحقق من اتصالك بالإنترنت');
      } else if (e.response != null) {
        throw ServerException(
          'حدث خطأ في الخادم: ${e.response?.statusCode}',
        );
      } else {
        throw ServerException('حدث خطأ غير متوقع');
      }
    } catch (e) {
      throw ServerException('حدث خطأ أثناء تحميل البراندات');
    }
  }
}
