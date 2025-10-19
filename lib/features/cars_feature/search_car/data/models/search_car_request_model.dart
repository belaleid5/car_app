import 'package:car_app/features/cars_feature/search_car/domain/entities/search_car_request_entity.dart';

class SearchCarRequestModel extends SearchCarRequestEntity {
  const SearchCarRequestModel({
    required super.type,
    required super.brandId,
    required super.locationId,
    required super.colorId,
    required super.seatingCapacity,
    required super.fuelType,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'brand_id': brandId,
      'location_id': locationId,
      'color_id': colorId,
      'seating_capacity': seatingCapacity,
      'fuel_type': fuelType,
    };
  }

  factory SearchCarRequestModel.fromEntity(SearchCarRequestEntity entity) {
    return SearchCarRequestModel(
      type: entity.type,
      brandId: entity.brandId,
      locationId: entity.locationId,
      colorId: entity.colorId,
      seatingCapacity: entity.seatingCapacity,
      fuelType: entity.fuelType,
    );
  }
}
