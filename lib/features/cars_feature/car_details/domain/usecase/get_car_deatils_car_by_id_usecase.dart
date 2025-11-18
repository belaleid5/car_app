import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/details_review_repo.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/card_id_prams.dart';
import 'package:dartz/dartz.dart';

class GetCarByIdUseCase implements BaseUseCase<CarEntity, CarIdParams> {
  final DetailsReviewRepository _repository;

  GetCarByIdUseCase(this._repository);

  @override
  Future<Either<Failure, CarEntity>> call(CarIdParams params) async {
    return await _repository.getCarById(params.carId);
  }
}