import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/location_page_entity.dart';
import 'package:car_app/features/auth/domain/params/get_location_params.dart';
import 'package:car_app/features/auth/domain/repositories/location_repos.dart';
import 'package:dartz/dartz.dart';

class GetLocationsUseCase implements BaseUseCase<LocationPageEntity, GetLocationsParams> {
  final LocationRepository repository;

  const GetLocationsUseCase(this.repository);

  @override
  Future<Either<Failure, LocationPageEntity>> call(GetLocationsParams params) async {
    return await repository.getLocations(page: params.page);
  }
}