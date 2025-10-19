import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/cars_feature/search_car/data/data_source/remote_data_source.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/search_car_request_model.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/paginated_search_car_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/search_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/repo/search_car_repo.dart';
import 'package:dartz/dartz.dart';

class SearchCarRepositoryImpl implements SearchCarRepository {
  final SearchCarsRemoteDataSource remoteDataSource;

  SearchCarRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedSearchCarsEntity>> searchCars(
      SearchCarRequestEntity params) async {
    try {
      final model = SearchCarRequestModel.fromEntity(params);
      final result = await remoteDataSource.searchCars(model);
      return result.fold(
        (failure) => Left(failure),
        (paginatedCarsModel) => Right(paginatedCarsModel),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
