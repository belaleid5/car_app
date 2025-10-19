import 'package:car_app/features/cars_feature/car_details/domain/entites/users_review_enityt.dart';
import 'package:car_app/features/cars_feature/home/data/mapping/meta_pagination.dart';
import 'package:equatable/equatable.dart';

class UsersReviewResponseEntity extends Equatable {
  final List<UsersReviewEntity> reviews;
  final PaginationMeta meta;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const UsersReviewResponseEntity({
    required this.reviews,
    required this.meta,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  List<Object?> get props => [reviews, meta, hasNextPage, hasPreviousPage];
}