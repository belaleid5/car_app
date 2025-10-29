import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/cars_reponse_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/usecase/params/page_currenrt_params.dart';
import 'package:dartz/dartz.dart';

class GetBestCarsUseCase
    implements BaseUseCase<CarsSearchResponseEntity, PageCurrentCarsParams> {
  final HomeRepo repository;

  GetBestCarsUseCase(this.repository);

  @override
  Future<Either<Failure, CarsSearchResponseEntity>> call(
      PageCurrentCarsParams params) async {
    return await repository.getBestCars(page: params.page);
  }
}
