import 'package:car_app/features/cars_feature/search_car/domain/entities/price_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';

class CarFilterEntity {
  final String? carType;
  final PriceRangeEntity? priceRange;
  final String? rentalTime;
  final DateTime? pickupDate;
  final int? locationId;
  final int? colorId;
  final int? seatingCapacity;
  final String? fuelType;
  final int? brandId;

  const CarFilterEntity({
    this.carType,
    this.priceRange,
    this.rentalTime,
    this.pickupDate,
    this.locationId,
    this.colorId,
    this.seatingCapacity,
    this.fuelType,
    this.brandId,
  });

  CarFilterEntity copyWith({
    String? carType,
    PriceRangeEntity? priceRange,
    String? rentalTime,
    DateTime? pickupDate,
    int? locationId,
    int? colorId,
    int? seatingCapacity,
    String? fuelType,
    int? brandId,
  }) {
    return CarFilterEntity(
      carType: carType ?? this.carType,
      priceRange: priceRange ?? this.priceRange,
      rentalTime: rentalTime ?? this.rentalTime,
      pickupDate: pickupDate ?? this.pickupDate,
      locationId: locationId ?? this.locationId,
      colorId: colorId ?? this.colorId,
      seatingCapacity: seatingCapacity ?? this.seatingCapacity,
      fuelType: fuelType ?? this.fuelType,
      brandId: brandId ?? this.brandId,
    );
  }
  

  bool get hasActiveFilters =>
      carType != null ||
      priceRange != null ||
      rentalTime != null ||
      pickupDate != null ||
      locationId != null ||
      colorId != null ||
      seatingCapacity != null ||
      fuelType != null ||
      brandId != null;

  CarFilterEntity clear() => const CarFilterEntity();

  SearchCarRequestEntity toSearchRequest() {
    return SearchCarRequestEntity(
      type: carType,
      brandId: brandId,
      locationId: locationId,
      colorId: colorId,
      seatingCapacity: seatingCapacity,
      fuelType: fuelType,
    );
  }
}
