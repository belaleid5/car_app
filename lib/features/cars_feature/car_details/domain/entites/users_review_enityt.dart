import 'package:equatable/equatable.dart';

class UsersReviewEntity extends Equatable {
  final int id;
  final String username;
  final String review;
  final String userImage;
  final int rate;

  const UsersReviewEntity({
    required this.id,
    required this.username,
    required this.review,
    required this.userImage,
    required this.rate,
  });

  @override
  List<Object?> get props => [id, username, review, userImage, rate];
}