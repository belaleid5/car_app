import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/shared/brands_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/cars_reponse_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BrandEntity>>> getBrands({int page = 1});
   Future<Either<Failure, CarsResponseEntity>> getBestCars({int page = 1});

  // NEW: Nearest cars
  Future<Either<Failure, CarsResponseEntity>> getNearestCars({
    required int locationId,
    int page = 1,
  });
}
