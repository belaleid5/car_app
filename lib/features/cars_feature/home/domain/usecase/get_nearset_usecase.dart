import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/cars_reponse_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetNearestCarsUseCase
    implements BaseUseCase<CarsResponseEntity, GetNearestCarsParams> {
  final HomeRepo repository;

  GetNearestCarsUseCase(this.repository);

  @override
  Future<Either<Failure, CarsResponseEntity>> call(
      GetNearestCarsParams params) async {
    return await repository.getNearestCars(
      locationId: params.locationId,
      page: params.page,
    );
  }
}

class GetNearestCarsParams extends Equatable {
  final int locationId;
  final int page;

  const GetNearestCarsParams({
    required this.locationId,
    this.page = 1,
  });

  @override
  List<Object> get props => [locationId, page];
}
