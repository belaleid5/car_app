import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/pagination_review_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DetailsReviewRepository {
  /// جلب المراجعات حسب ID السيارة
  Future<Either<Failure, PaginatedReviewsEntity>> getReviewsByCarId({
    required int carId,
    int page = 1,
    int perPage = 5,
  });

  Future<Either<Failure, CarEntity>> getCarById(int carId);
}