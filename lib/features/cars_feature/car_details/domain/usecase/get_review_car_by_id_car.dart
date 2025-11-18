import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/pagination_review_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/details_review_repo.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_review_cars_usecase.dart';
import 'package:dartz/dartz.dart';

class GetReviewsByCarIdUseCase 
    implements BaseUseCase<PaginatedReviewsEntity, GetReviewsByCarIdParams> {
  final DetailsReviewRepository _repository;

  /// Dependency Injection عبر Constructor
  GetReviewsByCarIdUseCase(this._repository);

  @override
  Future<Either<Failure, PaginatedReviewsEntity>> call(
    GetReviewsByCarIdParams params,
  ) async {
    return await _repository.getReviewsByCarId(
      carId: params.carId,
      page: params.page,
      perPage: params.perPage,
    );
  }
}
