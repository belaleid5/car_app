import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/paginated_search_car_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/search_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/repo/search_car_repo.dart';
import 'package:dartz/dartz.dart';

class SearchCarUseCase
    implements BaseUseCase<PaginatedSearchCarsEntity, SearchCarRequestEntity> {
  final SearchCarRepository repository;

  SearchCarUseCase(this.repository);

  @override
  Future<Either<Failure, PaginatedSearchCarsEntity>> call(
      SearchCarRequestEntity params) async {
    return await repository.searchCars(params);
  }
}
