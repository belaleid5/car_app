import 'package:car_app/features/cars_feature/home/domain/entity/paginated_car_entity.dart';
import 'package:car_app/core/shared/review_entity.dart';
import 'package:equatable/equatable.dart';

class PaginatedReviewsEntity extends Equatable {
  final List<ReviewEntity> reviews;
  final PaginationMetaEntity meta;

  const PaginatedReviewsEntity({
    required this.reviews,
    required this.meta,
  });
  
  @override
  List<Object?> get props => [reviews, meta];
}