import 'package:equatable/equatable.dart';

class CarFeatureEntity extends Equatable {
  final int id;
  final String name;
  final String value;
  final String image;

  const CarFeatureEntity({
    required this.id,
    required this.name,
    required this.value,
    required this.image,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [];
}