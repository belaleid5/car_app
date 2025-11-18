import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/car_details/data/model/pagintion_review_model.dart';
import 'package:car_app/features/cars_feature/car_details/data/remote_data_source/remote_details_datasource.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/pagination_review_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/details_review_repo.dart';
import 'package:car_app/features/cars_feature/home/data/model/cars_model.dart';
import 'package:dartz/dartz.dart';

class DetailsReviewRepositoryImp implements DetailsReviewRepository {
  final ReviewRemoteDataSource _remoteDataSource;

  /// Dependency Injection عبر Constructor
  DetailsReviewRepositoryImp({
    required ReviewRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, PaginatedReviewsModel>> getReviewsByCarId({
    required int carId,
    int page = 1,
    int perPage = 5,
  }) async {
    try {
      final result = await _remoteDataSource.getReviewsByCarId(
        carId: carId,
        page: page,
        perPage: perPage,
      );
      
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, CarModel>> getCarById(int carId) async {
    try {
      final carModel = await _remoteDataSource.getCarById(carId);
      
      return Right(carModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}