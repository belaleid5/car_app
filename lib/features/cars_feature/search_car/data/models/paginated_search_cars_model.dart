import 'package:car_app/core/shared/location_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/brands_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_feature_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_image_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/colors_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/reivew_model.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/pagination_repsone_search_entity.dart';

class CarSearchResponseModel extends CarSearchEntityResponse {
  const CarSearchResponseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.owner,
    required super.firstImage,
    required super.images,
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
    required super.reviewsCount,
    required super.reviewsAvg,
  });

  factory CarSearchResponseModel.fromJson(Map<String, dynamic> json) {
    return CarSearchResponseModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      owner: json['owner'] ?? 0,
      firstImage: json['first_image'] ?? '',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => CarImageModel.fromJson(e))
          .toList(),
      carType: json['car_type'] ?? '',
      brand: BrandModel.fromJson(json['brand']),
      color: ColorModel.fromJson(json['color']),
      carFeatures: (json['car_features'] as List<dynamic>? ?? [])
          .map((e) => CarFeatureModel.fromJson(e))
          .toList(),
      seatingCapacity: json['seating_capacity'] ?? '',
      location: LocationModel.fromJson(json['location']),
      averageRate: (json['average_rate'] ?? 0).toDouble(),
      isForRent: json['is_for_rent'] ?? false,
      dailyRent: json['daily_rent'],
      weeklyRent: json['weekly_rent'],
      monthlyRent: json['monthly_rent'],
      yearlyRent: json['yearly_rent'],
      isForPay: json['is_for_pay'] ?? false,
      price: json['price'],
      availableToBook: json['available_to_book'] ?? false,
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => ReviewModel.fromJson(e))
          .toList(),
      reviewsCount: json['reviews_count'] ?? 0,
      reviewsAvg: (json['reviews_avg'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'owner': owner,
      'first_image': firstImage,
      'images': images.map((e) => (e as CarImageModel).toJson()).toList(),
      'car_type': carType,
      'brand': (brand as BrandModel).toJson(),
      'color': (color as ColorModel).toJson(),
      'car_features':
          carFeatures.map((e) => (e as CarFeatureModel).toJson()).toList(),
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
      'reviews_count': reviewsCount,
      'reviews_avg': reviewsAvg,
    };
  }
}