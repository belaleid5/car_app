import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth_feature/data/data_sources/location_local_datasource.dart';
import 'package:car_app/core/shared/location_entity.dart';
import 'package:car_app/features/auth_feature/domain/repositories/location_repo.dart';
import 'package:dartz/dartz.dart';
// ... other imports

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo; // للتأكد من وجود اتصال بالإنترنت

  LocationsRepositoryImpl({
    required this.remoteDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations(int page) async {
    // if (await networkInfo.isConnected) {
      try {
        final remoteLocations = await remoteDataSource.getLocations(page);
        return Right(remoteLocations);
      } on ServerException {
        return Left(ServerFailure("لاتوجد مواقع حاليا"));
      }
    // } else {
    //   return Left(OfflineFailure());
    // }
  }
}
