import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/reviews_repo.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/car_id_params.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:dartz/dartz.dart';


class GetCarByIdUseCase extends BaseUseCase<CarEntity, CarIdParams> {
  final ReviewRepository repository;

  GetCarByIdUseCase(this.repository);

  @override
  Future<Either<Failure, CarEntity>> call(CarIdParams params) async {
    return await repository.getCarById(params.carId);
  }
}