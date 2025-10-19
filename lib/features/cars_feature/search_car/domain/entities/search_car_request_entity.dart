import 'package:equatable/equatable.dart';

class SearchCarRequestEntity extends Equatable {
  final String type;
  final int brandId;
  final int locationId;
  final int colorId;
  final int seatingCapacity;
  final String fuelType;

  const SearchCarRequestEntity({
    required this.type,
    required this.brandId,
    required this.locationId,
    required this.colorId,
    required this.seatingCapacity,
    required this.fuelType,
  });

  @override
  List<Object?> get props =>
      [type, brandId, locationId, colorId, seatingCapacity, fuelType];
}
