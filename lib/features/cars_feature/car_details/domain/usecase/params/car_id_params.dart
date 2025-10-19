import 'package:equatable/equatable.dart';

class CarIdParams extends Equatable {
  final int carId;
  final int ? page;

  const CarIdParams({required this.carId,this.page});

  @override
  List<Object?> get props => [carId];
}