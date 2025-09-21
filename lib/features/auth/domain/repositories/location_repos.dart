import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:car_app/features/auth/domain/entities/location_page_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepository {

  Future<Either<Failure, LocationPageEntity>> getLocations({
    required int page,
  });

 
  Future<Either<Failure, LocationEntity>> getLocationById({
    required int id,
  });


  Future<Either<Failure, LocationPageEntity>> searchLocations({
    required String query,
    required int page,
  });
}