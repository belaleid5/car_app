import 'package:car_app/core/constants/api_constants.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/pagination_search_car_model.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/search_car_request_model.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCarsRemoteDataSource {
  Future<Either<Failure, PaginatedSearchCarsModel>> searchCars(SearchCarRequestModel request );
}

class SearchCarsBaseDataSource implements SearchCarsRemoteDataSource {
  @override
  Future<Either<Failure, PaginatedSearchCarsModel>> searchCars(SearchCarRequestModel request ) async {
    try {
      final response = await sl<DioClient>().dio.post(
        ApiConstants.searchCar,
        data: request.toJson(),
      );

      final statusCode = response.statusCode ?? 0;
      if (statusCode >= 200 && statusCode < 300) {
        final data = response.data;
        final model = PaginatedSearchCarsModel.fromJson(data);
        return Right(model);
      } else {
        return Left(ServerFailure('Server error: $statusCode'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
