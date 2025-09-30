import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/home/data/datasource/remote_data_source.dart';
import 'package:car_app/features/home/data/model/brands_model.dart';
import 'package:car_app/features/home/domain/Repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

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
}
