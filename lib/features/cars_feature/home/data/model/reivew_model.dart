import 'package:car_app/core/shared/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.username,
    required super.review,
    required super.rate, 
    required super.user_image,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      user_image: json["user_image"],
      id: json['id'] as int,
      username: json['username'] as String,
      review: json['review'] as String,
      rate: json['rate'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'review': review,
      'rate': rate,
    };
  }
}