import 'package:equatable/equatable.dart';

class CarIdParams extends Equatable {
  final int carId;

  const CarIdParams({required this.carId});

  @override
  List<Object?> get props => [carId];
}