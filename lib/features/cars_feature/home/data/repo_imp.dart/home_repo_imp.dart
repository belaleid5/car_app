import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/network/network_info.dart';
import 'package:car_app/features/cars_feature/home/data/datasource/local_data_source_cars.dart';
import 'package:car_app/features/cars_feature/home/data/datasource/remote_data_source.dart';
import 'package:car_app/features/cars_feature/home/data/model/brands_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_response_model.dart';
import 'package:car_app/features/cars_feature/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/cars_reponse_entity.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;
  final CarsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl(
      {required this.localDataSource,
      required this.networkInfo,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BrandModel>>> getBrands({int page = 1}) async {
    try {
      final brands = await remoteDataSource.getBrands(page: page);
      return Right(brands);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, CarsSearchResponseEntity>> getBestCars(
      {int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCars = await remoteDataSource.getBestCars(page: page);
        if (page == 1) {
          await localDataSource.cacheBestCars(remoteCars);
        }
        return Right(remoteCars);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      }
    } else {
      try {
        final localCars = await localDataSource.getCachedBestCars();
        return Right(localCars);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, CarsResponseModel>> getNearestCars({
    required int locationId,
    int page = 1,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final cars = await remoteDataSource.getNearestCars(
          locationId: locationId,
          page: page,
        );
        return Right(cars);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
  

}
