import 'package:car_app/features/cars_feature/car_details/domain/entites/details_pagination_meta_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/review_details_entity.dart';
import 'package:equatable/equatable.dart';

class PaginatedReviewsEntity extends Equatable {
  final List<ReviewDetailsEntity> reviews;
  final DetailsPaginationMetaEntity meta;

  const PaginatedReviewsEntity({
    required this.reviews,
    required this.meta,
  });

  /// Helper getters للوصول السريع
  bool get hasNextPage => meta.hasNextPage;
  bool get hasPreviousPage => meta.hasPreviousPage;
  bool get isEmpty => reviews.isEmpty;
  int get totalReviews => meta.total;

  @override
  List<Object?> get props => [reviews, meta];
}
