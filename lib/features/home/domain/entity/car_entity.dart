
import 'package:car_app/core/shared/location_entity.dart';
import 'package:car_app/features/home/domain/entity/brands_entity.dart';
import 'package:car_app/features/home/domain/entity/car_features.dart';
import 'package:car_app/features/home/domain/entity/car_image_entity.dart';
import 'package:car_app/features/home/domain/entity/color_entity.dart';
import 'package:car_app/features/home/domain/entity/review_entity.dart';
import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final int id;
  final String name;
  final String firstImage;
  final List<CarImageEntity> images;
  final String description;
  final String carType;
  final BrandEntity brand;
  final ColorEntity color;
  final List<CarFeatureEntity> carFeatures;
  final int? seatingCapacity;
  final LocationEntity? location;
  final double averageRate;
  final bool isForRent;
  final double? dailyRent;
  final double? weeklyRent;
  final double? monthlyRent;
  final double? yearlyRent;
  final bool isForPay;
  final double? price;
  final bool availableToBook;
  final List<ReviewEntity> reviews;

  const CarEntity({
    required this.id,
    required this.name,
    required this.firstImage,
    required this.images,
    required this.description,
    required this.carType,
    required this.brand,
    required this.color,
    required this.carFeatures,
    this.seatingCapacity,
    this.location,
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
  });

  // Helper getter for main image with full URL
  String get mainImageUrl {
    if (images.isNotEmpty) {
      return images.first.image;
    }
    if (firstImage.startsWith('http')) {
      return firstImage;
    }
    return 'http://qent.up.railway.app$firstImage';
  }

  String get locationName => location?.name ?? 'Unknown Location';

  String get seatsDisplay => seatingCapacity?.toString() ?? '4';

  @override
  List<Object?> get props => [
        id,
        name,
        firstImage,
        images,
        description,
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
      ];
}
