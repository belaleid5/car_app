

import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/core/shared/location_entity.dart';
import 'package:car_app/features/auth_feature/domain/repositories/location_repo.dart';
import 'package:dartz/dartz.dart';

class GetLocationsUseCase implements BaseUseCase<List<LocationEntity>, int> {
  final LocationsRepository repository;

  GetLocationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LocationEntity>>> call(int params) async {
    return await repository.getLocations(params);
  }
}
