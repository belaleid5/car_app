import 'package:car_app/features/cars_feature/car_details/data/model/pagenated_reivw_model.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/review_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/users_review_response_entity.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_app/core/error/faliure.dart';

abstract class ReviewRepository {
  Future<Either<Failure, PaginatedReviewsEntity>> getReviewsByCarId({
    required int carId,
    int page = 1,
    int perPage = 5,
  });

    Future<Either<Failure, CarEntity>> getCarById(int carId);


    Future<Either<Failure, PaginatedReviewsModel>> getUsersCarReviews(
    int carId, 
    {
    int page = 1,
  });

}
