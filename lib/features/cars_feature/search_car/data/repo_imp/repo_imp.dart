import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/cars_feature/search_car/data/data_source/remote_datasource.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/search_request_model.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/pagination_search_response_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/repo/search_cars_repo.dart';
import 'package:dartz/dartz.dart';

class SearchCarRepoImpl implements SearchCarRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchCarRepoImpl(this.searchRemoteDataSource);

  @override
  Future<Either<Failure, PaginationResponseSearchEntity>> searchRequest(
    SearchCarRequestEntity params,
  ) async {
    try {
      final requestModel = SearchCarRequestModel(
        type: params.type,
        brandId: params.brandId,
        locationId: params.locationId,
        colorId: params.colorId,
        seatingCapacity: params.seatingCapacity,
        fuelType: params.fuelType,
      );

      // استدعاء الداتا من الريموت (بيرجع List)
      final carsList = await searchRemoteDataSource.requestSearchCar(requestModel);

      // تحويل List إلى PaginationResponse
      final paginationResponse = PaginationResponseSearchEntity(
        cars: carsList,
        currentPage: 1,
        totalPages: 1,
        totalItems: carsList.length,
        hasNextPage: false,
        hasPreviousPage: false,
      );

      return Right(paginationResponse);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginationResponseSearchEntity>> getAllCars() async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}