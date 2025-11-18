import 'package:equatable/equatable.dart';

class GetReviewsByCarIdParams extends Equatable {
  final int carId;
  final int page;
  final int perPage;

  const GetReviewsByCarIdParams({
    required this.carId,
    this.page = 1,
    this.perPage = 5,
  });

  @override
  List<Object?> get props => [carId, page, perPage];
}