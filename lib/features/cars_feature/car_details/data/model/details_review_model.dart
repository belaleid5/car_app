import 'package:car_app/features/cars_feature/car_details/domain/entites/review_details_entity.dart';

class DetailsReviewModel extends ReviewDetailsEntity {
  const DetailsReviewModel({
    required super.id,
    required super.username,
    required super.review,
    required super.userImage,
    required super.rate,
  });

  /// Factory Constructor للتحويل من JSON
  factory DetailsReviewModel.fromJson(Map<String, dynamic> json) {
    return DetailsReviewModel(
      id: json['id'] as int,
      username: json['username'] as String,
      review: json['review'] as String,
      userImage: json['user_image'] as String,
      rate: json['rate'] as int,
    );
  }

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'review': review,
      'user_image': userImage,
      'rate': rate,
    };
  }

  /// تحويل من Model إلى Entity
  /// للحفاظ على فصل الطبقات
  ReviewDetailsEntity toEntity() {
    return ReviewDetailsEntity(
      id: id,
      username: username,
      review: review,
      userImage: userImage,
      rate: rate,
    );
  }
}
