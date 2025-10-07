import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/car_details_repo.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/car_id_params.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';


class GetCarByIdUseCase extends BaseUseCase<CarEntity, CarIdParams> {
  final CarRepository repository;

  GetCarByIdUseCase(this.repository);

  @override
  Future<Either<Failure, CarEntity>> call(CarIdParams params) async {
    return await repository.getCarById(params.carId);
  }
}




