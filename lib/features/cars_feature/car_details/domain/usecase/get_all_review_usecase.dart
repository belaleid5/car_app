import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/car_details/data/model/pagenated_reivw_model.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/reviews_repo.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/car_id_params.dart';
import 'package:dartz/dartz.dart';

class GetAllReviewsUseCase
    implements BaseUseCase<PaginatedReviewsModel, CarIdParams> {
  final ReviewRepository repository;

  GetAllReviewsUseCase(this.repository);

  @override
  Future<Either<Failure, PaginatedReviewsModel>> call(
      CarIdParams params) async {
    return await repository.getUsersCarReviews(
      params.carId,
      page: params.page!,
    );
  }
}
