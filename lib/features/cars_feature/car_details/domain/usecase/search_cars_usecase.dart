import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/car_details_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchCarsUseCase extends BaseUseCase<List<CarEntity>, SearchCarsParams> {
  final CarRepository repository;

  SearchCarsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CarEntity>>> call(SearchCarsParams params) async {
    return await repository.searchCars(params.query);
  }
}

class SearchCarsParams extends Equatable {
  final String query;

  const SearchCarsParams({required this.query});

  @override
  List<Object?> get props => [query];
}