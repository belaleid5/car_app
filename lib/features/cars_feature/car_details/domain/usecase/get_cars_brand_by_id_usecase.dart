import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/car_details_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCarsByBrandUseCase extends BaseUseCase<List<CarEntity>, BrandIdParams> {
  final CarRepository repository;

  GetCarsByBrandUseCase(this.repository);

  @override
  Future<Either<Failure, List<CarEntity>>> call(BrandIdParams params) async {
    return await repository.getCarsByBrand(params.brandId);
  }
}

class BrandIdParams extends Equatable {
  final int brandId;

  const BrandIdParams({required this.brandId});

  @override
  List<Object?> get props => [brandId];
}