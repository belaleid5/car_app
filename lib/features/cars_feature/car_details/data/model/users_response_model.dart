import 'package:car_app/features/cars_feature/car_details/domain/entites/users_review_enityt.dart';

class UserReviewResponseModel extends UsersReviewEntity {
  const UserReviewResponseModel({
    required super.id,
    required super.username,
    required super.review,
    required super.userImage,
    required super.rate,
  });

 
// في ReviewModel.fromJson
factory UserReviewResponseModel.fromJson(Map<String, dynamic> json) {
  return UserReviewResponseModel(
    id: json['id'] as int,
    username: json['username'] as String,
    review: json['review'] as String,
    userImage: json['user_image'] as String, // ✅ تأكد من الاسم صح
    rate: json['rate'] as int,
  );
}
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'review': review,
      'user_image': userImage,
      'rate': rate,
    };
  }

  UserReviewResponseModel copyWith({
    int? id,
    String? username,
    String? review,
    String? userImage,
    int? rate,
  }) {
    return UserReviewResponseModel(
      id: id ?? this.id,
      username: username ?? this.username,
      review: review ?? this.review,
      userImage: userImage ?? this.userImage,
      rate: rate ?? this.rate,
    );
  }
}
