import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:car_app/features/auth/domain/params/get-location_by_id_params.dart';
import 'package:car_app/features/auth/domain/repositories/location_repos.dart';
import 'package:dartz/dartz.dart';

class GetLocationByIdUseCase implements BaseUseCase<LocationEntity, GetLocationByIdParams> {
  final LocationRepository repository;

  const GetLocationByIdUseCase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(GetLocationByIdParams params) async {
    return await repository.getLocationById(id: params.id);
  }
}