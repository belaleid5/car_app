import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/home/domain/entity/brands_entity.dart';
import 'package:dartz/dartz.dart';

class GetBrandsUseCase extends BaseUseCase<List<BrandEntity>, BrandParams> {
 final HomeRepo homeRepo;

  GetBrandsUseCase({required this.homeRepo});
  @override
   @override
  Future<Either<Failure, List<BrandEntity>>> call(BrandParams params) async {
    return await homeRepo.getBrands(page: params.page);
  }

} 








class BrandParams {
  final int page;

  const BrandParams({this.page = 1});
}