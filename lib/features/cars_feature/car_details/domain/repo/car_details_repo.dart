import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/review_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CarRepository {
  /// Get all cars with pagination
  Future<Either<Failure, List<CarEntity>>> getAllCars({
    required int page,
    required int limit,
  });

  /// Get car by ID
  Future<Either<Failure, CarEntity>> getCarById(int carId);

  /// Search cars by query
  Future<Either<Failure, List<CarEntity>>> searchCars(String query);

  /// Get cars by brand ID
  Future<Either<Failure, List<CarEntity>>> getCarsByBrand(int brandId);
  Future<Either<Failure, ReviewEntity>> getCarsReview(int carId);
}