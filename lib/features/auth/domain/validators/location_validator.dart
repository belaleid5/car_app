import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:dartz/dartz.dart';

class LocationValidator {
  static Either<ValidationFailure, int> validatePage(int page) {
    if (page < 1) {
      return Left(ValidationFailure(
       'Page number must be greater than 0',
       400,
      ));
    }
    return Right(page);
  }

  static Either<ValidationFailure, int> validateLocationId(int id) {
    if (id < 1) {
      return Left(ValidationFailure(
         'Location ID must be greater than 0',
         400,
      ));
    }
    return Right(id);
  }

  static Either<ValidationFailure, String> validateSearchQuery(String query) {
    final trimmedQuery = query.trim();
    
    if (trimmedQuery.isEmpty) {
      return Left(ValidationFailure(
         'Search query cannot be empty',
         400,
      ));
    }
    
    if (trimmedQuery.length < 2) {
      return Left(ValidationFailure(
         'Search query must be at least 2 characters long',
         400,
      ));
    }
    
    return Right(trimmedQuery);
  }

  static Either<ValidationFailure, LocationEntity> validateLocation(LocationEntity location) {
    if (location.name.trim().isEmpty) {
      return Left(ValidationFailure(
         'Location name cannot be empty',
         400,
      ));
    }
    
    if (location.latitude < -90 || location.latitude > 90) {
      return Left(ValidationFailure(
         'Latitude must be between -90 and 90',
         400,
      ));
    }
    
    if (location.longitude < -180 || location.longitude > 180) {
      return Left(ValidationFailure(
         'Longitude must be between -180 and 180',
         400,
      ));
    }
    
    return Right(location);
  }
}