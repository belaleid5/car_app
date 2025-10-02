import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/home/domain/entity/cars_reponse_entity.dart';
import 'package:dartz/dartz.dart';

class GetBestCarsUseCase {
  final HomeRepo repository;

  GetBestCarsUseCase(this.repository);

  Future<Either<Failure, CarsResponseEntity>> call({int page = 1}) async {
    return await repository.getBestCars(page: page);
  }
}