// data/repositories/review_repository_impl.dart
import 'package:car_app/features/cars_feature/car_details/data/model/pagenated_reivw_model.dart';
import 'package:car_app/features/cars_feature/car_details/data/remote_data_source/car_remote_data_source.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/review_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/reviews_repo.dart';
import 'package:car_app/features/cars_feature/home/data/model/cars_model.dart';
import 'package:dartz/dartz.dart';
import 'package:car_app/core/error/faliure.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});








  @override
  Future<Either<Failure, PaginatedReviewsEntity>> getReviewsByCarId({
    required int carId,
    int page = 1,
    int perPage = 5,
  }) async {
    try {
      final result = await remoteDataSource.getReviewsByCarId(
        carId: carId,
        page: page,
        perPage: perPage,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }
  


  @override
  Future<Either<Failure, CarModel>> getCarById(int carId) async {
    try {
      final car = await remoteDataSource.getCarById(carId);
      return Right(car);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, PaginatedReviewsModel>> getUsersCarReviews(
    int carId, // ✅ شيلت الـ ? (non-nullable)
    {
    int page = 1,
  }) async {
    try {
      final result = await remoteDataSource.getUsersCarReviews(carId, page);
      return Right(result.toEntity()); 
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع: $e'));
    }
  }






}