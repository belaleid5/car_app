import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/paginated_search_car_entity.dart' show PaginatedSearchCarsEntity;
import 'package:car_app/features/cars_feature/search_car/domain/entities/search_car_request_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCarRepository {
  Future<Either<Failure, PaginatedSearchCarsEntity>> searchCars(
      SearchCarRequestEntity request);
}