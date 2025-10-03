import 'package:equatable/equatable.dart';

class CarImageEntity extends Equatable {
  final int id;
  final String image;

  const CarImageEntity({
    required this.id,
    required this.image,
  });

  @override
  List<Object?> get props => [id, image];
}