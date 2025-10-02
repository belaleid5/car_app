import 'package:car_app/core/shared/location_model.dart';
import 'package:car_app/features/home/data/model/brands_model.dart';
import 'package:car_app/features/home/data/model/car_feature_model.dart';
import 'package:car_app/features/home/data/model/colors_model.dart';
import 'package:car_app/features/home/data/model/reivew_model.dart';
import 'package:car_app/features/home/domain/entity/car_entity.dart';

class CarModel extends CarEntity {
 const CarModel({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.carType,
    required super.brand,
    required super.color,
    required super.carFeatures,
    required super.seatingCapacity,
    required super.location,
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
      image: json['image'] as String,
      description: json['description'] as String,
      carType: json['car_type'] as String,
      brand: BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      color: ColorModel.fromJson(json['color'] as Map<String, dynamic>),
      carFeatures: (json['car_features'] as List)
          .map((e) => CarFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      seatingCapacity: json['seating_capacity'] as int,
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      averageRate: (json['average_rate'] as num).toDouble(),
      isForRent: json['is_for_rent'] as bool,
      dailyRent: json['daily_rent'] != null ? (json['daily_rent'] as num).toDouble() : null,
      weeklyRent: json['weekly_rent'] != null ? (json['weekly_rent'] as num).toDouble() : null,
      monthlyRent: json['monthly_rent'] != null ? (json['monthly_rent'] as num).toDouble() : null,
      yearlyRent: json['yearly_rent'] != null ? (json['yearly_rent'] as num).toDouble() : null,
      isForPay: json['is_for_pay'] as bool,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      availableToBook: json['available_to_book'] as bool,
      reviews: (json['reviews'] as List)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'car_type': carType,
      'brand': (brand as BrandModel).toJson(),
      'color': (color as ColorModel).toJson(),
      'car_features': carFeatures.map((e) => (e as CarFeatureModel).toJson()).toList(),
      'seating_capacity': seatingCapacity,
      'location': (location as LocationModel).toJson(),
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
