// lib/features/cars_feature/search_car/data/models/search_car_request_model.dart


import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';

class SearchCarRequestModel extends SearchCarRequestEntity {
  const SearchCarRequestModel({
    super.type,
    super.brandId,
    super.locationId,
    super.colorId,
    super.seatingCapacity,
    super.fuelType,
  });

  /// ✅ toJson محسّن - بيبعت القيم اللي مش null بس
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (type != null) data['type'] = type;
    if (brandId != null) data['brand_id'] = brandId;
    if (locationId != null) data['location_id'] = locationId;
    if (colorId != null) data['color_id'] = colorId;
    if (seatingCapacity != null) data['seating_capacity'] = seatingCapacity;
    if (fuelType != null) data['fuel_type'] = fuelType;
    
    return data;
  }

  /// ✅ fromJson محسّن
  factory SearchCarRequestModel.fromJson(Map<String, dynamic> json) {
    return SearchCarRequestModel(
      type: json['type'] as String?,
      brandId: _parseInt(json['brand_id']),
      locationId: _parseInt(json['location_id']),
      colorId: _parseInt(json['color_id']),
      seatingCapacity: _parseInt(json['seating_capacity']),
      fuelType: json['fuel_type'] as String?,
    );
  }

  /// ✅ Helper method لتحويل القيم لـ int بأمان
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// ✅ copyWith للتعديل السهل
  SearchCarRequestModel copyWith({
    String? type,
    int? brandId,
    int? locationId,
    int? colorId,
    int? seatingCapacity,
    String? fuelType,
  }) {
    return SearchCarRequestModel(
      type: type ?? this.type,
      brandId: brandId ?? this.brandId,
      locationId: locationId ?? this.locationId,
      colorId: colorId ?? this.colorId,
      seatingCapacity: seatingCapacity ?? this.seatingCapacity,
      fuelType: fuelType ?? this.fuelType,
    );
  }
}