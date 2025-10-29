import 'package:car_app/core/constants/api_constants.dart';
import 'package:car_app/core/error/dio_excaeption.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/paginated_search_cars_model.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/search_request_model.dart';
import 'package:dio/dio.dart';

/// ✅ الواجهة (Contract)
abstract class SearchRemoteDataSource {
  Future<List<CarSearchResponseModel>> requestSearchCar(
    SearchCarRequestModel params,
  );
}

/// ✅ التنفيذ (Implementation)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<List<CarSearchResponseModel>> requestSearchCar(
    SearchCarRequestModel params,
  ) async {
    try {
      final response = await sl<DioClient>().dio.post(
            ApiConstants.search,
            data: params.toJson(),
            options: Options(
              headers: {
                ApiConstants.contentType: ApiConstants.applicationJson,
              },
            ),
          );

      final statusCode = response.statusCode ?? 500;

      if (statusCode == 200 || statusCode == 201) {
        final data = response.data;

        /// ✅ لو الـ API بيرجع List (وهو المتوقع)
        if (data is List) {
          return data
              .map((e) => CarSearchResponseModel.fromJson(e))
              .toList();
        }

        /// ✅ لو بيرجع Map تحتوي على المفتاح "data"
        else if (data is Map<String, dynamic> && data['data'] is List) {
          return (data['data'] as List)
              .map((e) => CarSearchResponseModel.fromJson(e))
              .toList();
        }

        /// ❌ غير كده نرمي Exception
        else {
          throw ServerException('Invalid response format', statusCode);
        }
      } else {
        throw ServerException(
          'Search failed with status: $statusCode',
          statusCode,
        );
      }
    } on DioException catch (e) {
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}
