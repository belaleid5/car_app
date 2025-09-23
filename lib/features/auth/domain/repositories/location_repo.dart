import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/domain/entities/location_entity.dart';
import 'package:dartz/dartz.dart'; // مكتبة لمعالجة الأخطاء


abstract class LocationsRepository {
  Future<Either<Failure, List<LocationEntity>>> getLocations(int page);
}
