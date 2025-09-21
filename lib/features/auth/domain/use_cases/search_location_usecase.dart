import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/location_page_entity.dart';
import 'package:car_app/features/auth/domain/params/search_location_params.dart';
import 'package:car_app/features/auth/domain/repositories/location_repos.dart';
import 'package:dartz/dartz.dart';

class SearchLocationsUseCase implements BaseUseCase<LocationPageEntity, SearchLocationsParams> {
  final LocationRepository repository;

  const SearchLocationsUseCase(this.repository);

  @override
  Future<Either<Failure, LocationPageEntity>> call(SearchLocationsParams params) async {
    return await repository.searchLocations(
      query: params.query,
      page: params.page,
    );
  }
}