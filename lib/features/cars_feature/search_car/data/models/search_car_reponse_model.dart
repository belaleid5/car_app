import 'package:car_app/core/shared/location_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/brands_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_feature_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_image_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/colors_model.dart';
import 'package:car_app/features/cars_feature/home/data/model/reivew_model.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/search_car_response_entity.dart';

class SearchCarResponseModel extends SearchCarResponseEntity {
  const SearchCarResponseModel({
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

  factory SearchCarResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchCarResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      owner: json['owner'] as int,
      firstImage: json['first_image'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => CarImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      brand: BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      color: ColorModel.fromJson(json['color'] as Map<String, dynamic>),
      carFeatures: (json['car_features'] as List<dynamic>)
          .map((e) => CarFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
         
      seatingCapacity: json['seating_capacity'] as String,
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      averageRate: json['average_rate'] as int,
      isForRent: json['is_for_rent'] as bool,
      dailyRent: json['daily_rent'] as String?,
      weeklyRent: json['weekly_rent'] as String?,
      monthlyRent: json['monthly_rent'] as String?,
      yearlyRent: json['yearly_rent'] as String?,
      isForPay: json['is_for_pay'] as bool,
      price: json['price'] as String?,
      availableToBook: json['available_to_book'] as bool,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewsCount: json['reviews_count'] as int,
      reviewsAvg: (json['reviews_avg'] as num).toDouble(), carType: '',
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
      'reviews_count': reviewsCount,
      'reviews_avg': reviewsAvg,
    };
  }
}
