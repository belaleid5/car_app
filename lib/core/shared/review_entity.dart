import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int id;
  final String username;
  final String review;
  final String user_image;
  final int rate;

  const ReviewEntity( {
    required this.id,
    required this.user_image,
    required this.username,
    required this.review,
    required this.rate,
  });

  @override
  List<Object?> get props => [
      id,
      username,
      review,
      user_image,
      rate,
  ];
}
