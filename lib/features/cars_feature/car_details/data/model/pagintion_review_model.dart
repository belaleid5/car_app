import 'package:car_app/features/cars_feature/car_details/data/model/details_review_model.dart';
import 'package:car_app/features/cars_feature/car_details/data/model/pagination_meta_review_model.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/pagination_review_entity.dart';

class PaginatedReviewsModel extends PaginatedReviewsEntity {
  const PaginatedReviewsModel({
    required super.reviews,
    required super.meta,
  });

  factory PaginatedReviewsModel.fromJson(Map<String, dynamic> json) {
    final meta = PaginationReviewMetaModel.fromJson(
      json['meta'] as Map<String, dynamic>,
    );
    
    final reviews = (json['data'] as List<dynamic>)
        .map((reviewJson) => DetailsReviewModel.fromJson(
              reviewJson as Map<String, dynamic>,
            ))
        .toList();

    return PaginatedReviewsModel(
      reviews: reviews,
      meta: meta,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': reviews
          .map((review) => (review as DetailsReviewModel).toJson())
          .toList(),
      'meta': (meta as PaginationReviewMetaModel).toJson(),
    };
  }

  PaginatedReviewsEntity toEntity() {
    return PaginatedReviewsEntity(
      reviews: reviews
          .map((review) => (review as DetailsReviewModel).toEntity())
          .toList(),
      meta: (meta as PaginationReviewMetaModel).toEntity(),
    );
  }
}