import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/cars_feature/car_details/data/remote_data_source/car_remote_data_source.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/car_details_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/review_entity.dart';
import 'package:dartz/dartz.dart';


class CarRepositoryImpl implements CarRepository {
  final CarRemoteDataSource remoteDataSource;

  CarRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CarEntity>>> getAllCars({
    required int page,
    required int limit,
  }) async {
    try {
      final cars = await remoteDataSource.getAllCars(page: page, limit: limit);
      return Right(cars);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, CarEntity>> getCarById(int carId) async {
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
  Future<Either<Failure, List<CarEntity>>> searchCars(String query) async {
    try {
      final cars = await remoteDataSource.searchCars(query);
      return Right(cars);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, List<CarEntity>>> getCarsByBrand(int brandId) async {
    try {
      final cars = await remoteDataSource.getCarsByBrand(brandId);
      return Right(cars);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, ReviewEntity>> getCarsReview(int carId) async {
    try {
      final reviews = await remoteDataSource.getCarsReview(carId);
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }
}
