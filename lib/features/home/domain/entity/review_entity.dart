import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int id;
  final String username;
  final String review;
  final int rate;

 const ReviewEntity({
    required this.id,
    required this.username,
    required this.review,
    required this.rate,
  });
  
  @override
  List<Object?> get props => [];
}