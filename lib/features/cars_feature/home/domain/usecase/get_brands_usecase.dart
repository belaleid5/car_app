import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/brands_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/usecase/params/page_currenrt_params.dart';
import 'package:dartz/dartz.dart';

class GetBrandsUseCase extends BaseUseCase<List<BrandEntity>, PageCurrentCarsParams> {
 final HomeRepo homeRepo;

  GetBrandsUseCase({required this.homeRepo});
  @override
   @override
  Future<Either<Failure, List<BrandEntity>>> call(PageCurrentCarsParams params) async {
    return await homeRepo.getBrands(page: params.page);
  }

} 






