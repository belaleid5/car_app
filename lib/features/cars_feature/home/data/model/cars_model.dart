
import 'package:car_app/core/shared/location_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/brands_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_feature_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_image_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/colors_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/reivew_model.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';


class CarModel extends CarEntity {
  const CarModel({
    required super.id,
    required super.name,
    required super.firstImage,
    required super.images,
    required super.description,
    required super.carType,
    required super.brand,
    required super.color,
    required super.carFeatures,
    super.seatingCapacity,
    super.location,
    required super.averageRate,
    required super.isForRent,
    super.dailyRent,
    super.weeklyRent,
    super.monthlyRent,
    super.yearlyRent,
    required super.isForPay,
    super.price,
    required super.availableToBook,
    required super.reviews,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as int,
      name: json['name'] as String,
      firstImage: json['first_image'] as String? ?? '',
      images: json['images'] != null
          ? (json['images'] as List)
              .map((e) => CarImageModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      description: json['description'] as String? ?? '',
      carType: json['car_type'] as String,
      brand: BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      color: ColorModel.fromJson(json['color'] as Map<String, dynamic>),
      carFeatures: json['car_features'] != null
          ? (json['car_features'] as List)
              .map((e) => CarFeatureModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      // ✅ Parse seating_capacity (String -> Int)
      seatingCapacity: _parseSeatingCapacity(json['seating_capacity']),
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      averageRate: json['average_rate'] != null
          ? (json['average_rate'] as num).toDouble()
          : 0.0,
      isForRent: json['is_for_rent'] as bool? ?? false,
      // ✅ Parse prices (String -> Double)
      dailyRent: _parsePrice(json['daily_rent']),
      weeklyRent: _parsePrice(json['weekly_rent']),
      monthlyRent: _parsePrice(json['monthly_rent']),
      yearlyRent: _parsePrice(json['yearly_rent']),
      isForPay: json['is_for_pay'] as bool? ?? false,
      price: _parsePrice(json['price']),
      availableToBook: json['available_to_book'] as bool? ?? true,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  // ✅ Helper: Parse seating capacity from String
  static int? _parseSeatingCapacity(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      // Extract number from "4 Seats" -> 4
      final match = RegExp(r'\d+').firstMatch(value);
      if (match != null) {
        return int.tryParse(match.group(0)!);
      }
    }
    return null;
  }

  // ✅ Helper: Parse price from String or num
  static double? _parsePrice(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'first_image': firstImage,
      'images': images.map((e) => (e as CarImageModel).toJson()).toList(),
      'description': description,
      'car_type': carType,
      'brand': (brand as BrandModel).toJson(),
      'color': (color as ColorModel).toJson(),
      'car_features': carFeatures
          .map((e) => (e as CarFeatureModel).toJson())
          .toList(),
      'seating_capacity': seatingCapacity,
      'location': location != null ? (location as LocationModel).toJson() : null,
      'average_rate': averageRate,
      'is_for_rent': isForRent,
      'daily_rent': dailyRent,
      'weekly_rent': weeklyRent,
      'monthly_rent': monthlyRent,
      'yearly_rent': yearlyRent,
      'is_for_pay': isForPay,
      'price': price,
      'available_to_book': availableToBook,
      'reviews': reviews.map((e) => (e as ReviewModel).toJson()).toList(),
    };
  }
}