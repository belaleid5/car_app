import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/review_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/reviews_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:equatable/equatable.dart';

class GetReviewsByCarIdParams extends Equatable {
  final int carId;
  final int page;
  final int perPage;

  const GetReviewsByCarIdParams({
    required this.carId,
    this.page = 1,
    this.perPage = 5,
  });

  @override
  List<Object?> get props => [carId, page, perPage];
}

class GetReviewsByCarIdUseCase 
    extends BaseUseCase<PaginatedReviewsEntity, GetReviewsByCarIdParams> {
  final ReviewRepository repository;

  GetReviewsByCarIdUseCase(this.repository);

  @override
  Future<Either<Failure, PaginatedReviewsEntity>> call(
    GetReviewsByCarIdParams params,
  ) async {
    return await repository.getReviewsByCarId(
      carId: params.carId,
      page: params.page,
      perPage: params.perPage,
    );
  }
}