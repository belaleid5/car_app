

import 'package:car_app/features/cars_feature/car_details/domain/entites/review_entity.dart';
import 'package:car_app/features/cars_feature/home/data/model/pagination_meta_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/reivew_model.dart';

class PaginatedReviewsModel extends PaginatedReviewsEntity {
  const PaginatedReviewsModel({
    required super.reviews,
    required super.meta,
  });

 factory PaginatedReviewsModel.fromJson(Map<String, dynamic> json) {
  final meta = PaginationMetaModel.fromJson(json['meta']);
  
  // ✅ تأكد من parsing الـ data array
  final reviews = (json['data'] as List<dynamic>)
      .map((reviewJson) => ReviewModel.fromJson(reviewJson as Map<String, dynamic>))
      .toList();

  print('📝 Parsed ${reviews.length} reviews'); // Debug

  return PaginatedReviewsModel(
    reviews: reviews,
    meta: meta,
  
  );
}

  Map<String, dynamic> toJson() {
    return {
      'data': reviews.map((review) => (review as ReviewModel).toJson()).toList(),
      'meta': (meta as PaginationMetaModel).toJson(),
    };
  }

  PaginatedReviewsModel toEntity() {
    return PaginatedReviewsModel(
      reviews: reviews,
      meta: meta,
    );
  }
}













