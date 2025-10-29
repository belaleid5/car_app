// lib/features/cars_feature/search_car/domain/entities/search_car_request_entity.dart

import 'package:equatable/equatable.dart';

class SearchCarRequestEntity extends Equatable {
  final String? type;
  final int? brandId;
  final int? locationId;
  final int? colorId;
  final int? seatingCapacity;
  final String? fuelType;

  const SearchCarRequestEntity({
    this.type,          // ✅ Optional
    this.brandId,       // ✅ Optional
    this.locationId,    // ✅ Optional
    this.colorId,       // ✅ Optional
    this.seatingCapacity, // ✅ Optional
    this.fuelType,      // ✅ Optional
  });

  @override
  List<Object?> get props => [
    type,
    brandId,
    locationId,
    colorId,
    seatingCapacity,
    fuelType,
  ];
}