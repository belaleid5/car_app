import 'package:car_app/core/shared/location_entity.dart';
import 'package:car_app/core/shared/brands_entity.dart';
import 'package:car_app/core/shared/car_features.dart';
import 'package:car_app/core/shared/car_image_entity.dart';
import 'package:car_app/core/shared/color_entity.dart';
import 'package:car_app/core/shared/review_entity.dart';
import 'package:equatable/equatable.dart';

class SearchCarResponseEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int owner;
  final String firstImage;
  final List<CarImageEntity> images;
  final String carType;
  final BrandEntity brand;
  final ColorEntity color;
  final List<CarFeatureEntity> carFeatures;
  final String seatingCapacity;
  final LocationEntity location;
  final int averageRate;
  final bool isForRent;
  final String? dailyRent;
  final String? weeklyRent;
  final String? monthlyRent;
  final String? yearlyRent;
  final bool isForPay;
  final String? price;
  final bool availableToBook;
  final List<ReviewEntity> reviews;
  final int reviewsCount;
  final double reviewsAvg;

  const SearchCarResponseEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.firstImage,
    required this.images,
    required this.carType,
    required this.brand,
    required this.color,
    required this.carFeatures,
    required this.seatingCapacity,
    required this.location,
    required this.averageRate,
    required this.isForRent,
    this.dailyRent,
    this.weeklyRent,
    this.monthlyRent,
    this.yearlyRent,
    required this.isForPay,
    this.price,
    required this.availableToBook,
    required this.reviews,
    required this.reviewsCount,
    required this.reviewsAvg,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        owner,
        firstImage,
        images,
        carType,
        brand,
        color,
        carFeatures,
        seatingCapacity,
        location,
        averageRate,
        isForRent,
        dailyRent,
        weeklyRent,
        monthlyRent,
        yearlyRent,
        isForPay,
        price,
        availableToBook,
        reviews,
        reviewsCount,
        reviewsAvg,
      ];
}