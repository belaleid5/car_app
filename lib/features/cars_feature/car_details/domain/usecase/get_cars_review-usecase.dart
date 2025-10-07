import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/car_details_repo.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/car_id_params.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/review_entity.dart';
import 'package:dartz/dartz.dart';

class GetCarsReviewUseCase extends BaseUseCase<ReviewEntity, CarIdParams> {
  final CarRepository repository;

  GetCarsReviewUseCase(this.repository);

  @override
  Future<Either<Failure, ReviewEntity>> call(CarIdParams params) async {
    final result = await repository.getCarsReview(params.carId);
  
    return result;
  }
}