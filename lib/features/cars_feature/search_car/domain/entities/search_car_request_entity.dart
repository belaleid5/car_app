import 'package:equatable/equatable.dart';

class SearchCarRequestEntity extends Equatable {
  final String ?type;
  final int ?brandId;
  final int ?locationId;
  final int ?colorId;
  final int ?seatingCapacity;
  final String ?fuelType;

  const SearchCarRequestEntity({
     this.type,
     this.brandId,
     this.locationId,
     this.colorId,
     this.seatingCapacity,
     this.fuelType,
  });

  @override
  List<Object?> get props =>
      [type, brandId, locationId, colorId, seatingCapacity, fuelType];
}
