import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/car_details_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllCarsUseCase extends BaseUseCase<List<CarEntity>, PaginationParams> {
  final CarRepository repository;

  GetAllCarsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CarEntity>>> call(PaginationParams params) async {
    return await repository.getAllCars(
      page: params.page,
      limit: params.limit,
    );
  }
}

class PaginationParams extends Equatable {
  final int page;
  final int limit;

  const PaginationParams({
    required this.page,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [page, limit];
}