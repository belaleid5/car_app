import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/car_repsone_search_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/pagination_search_response_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/repo/search_cars_repo.dart';
import 'package:dartz/dartz.dart';

class RequestSearchUseCase
    extends BaseUseCase<PaginationResponseSearchEntity, SearchCarRequestEntity> {
  final SearchCarRepository repository;

  RequestSearchUseCase(this.repository);

  @override
  Future<Either<Failure, PaginationResponseSearchEntity>> call(
      SearchCarRequestEntity params) async {
    return await repository.searchRequest(params);
  }
}
