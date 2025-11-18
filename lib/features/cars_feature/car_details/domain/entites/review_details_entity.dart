import 'package:equatable/equatable.dart';

class ReviewDetailsEntity extends Equatable {
  final int id;
  final String username;
  final String review;
  final String userImage;
  final int rate;

  const ReviewDetailsEntity({
    required this.id,
    required this.username,
    required this.review,
    required this.userImage,
    required this.rate,
  });

  @override
  List<Object?> get props => [id, username, review, userImage, rate];
}