import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/cars_feature/search_car/data/data_source/remote_datasource.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/paginated_search_cars_model.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/search_request_model.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/pagination_repsone_search_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/repo/search_cars_repo.dart';
import 'package:dartz/dartz.dart';

class SearchCarRepoImpl implements SearchCarRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchCarRepoImpl(this.searchRemoteDataSource);

  @override
  Future<Either<Failure, List<CarSearchResponseModel>>> searchRequest(
    SearchCarRequestEntity params,
  ) async {
    try {
      // تحويل من Entity إلى Model
      final requestModel = SearchCarRequestModel(
        type: params.type,
        brandId: params.brandId,
        locationId: params.locationId,
        colorId: params.colorId,
        seatingCapacity: params.seatingCapacity,
        fuelType: params.fuelType,
      );

      // استدعاء الداتا من الريموت
      final result = await searchRemoteDataSource.requestSearchCar(requestModel);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CarSearchEntityResponse>>> getAllCars() {
    // TODO: implement getAllCars
    throw UnimplementedError();
  }
}
