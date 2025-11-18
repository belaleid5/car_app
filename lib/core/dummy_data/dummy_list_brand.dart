import 'package:car_app/core/shared/brands_entity.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/core/shared/color_entity.dart';
import 'package:car_app/core/shared/location_entity.dart';
import 'package:car_app/core/utils/app_images.dart';

class DummiesData {
  List<BrandEntity> dummyBrandItem() {
  return [
    BrandEntity(id: 0, name: 'Brand A', image: AppImages.brand_icon),
    BrandEntity(id: 1, name: 'Brand B', image: AppImages.brand_icon),
    BrandEntity(id: 0, name: 'Brand A', image: AppImages.brand_icon),
    BrandEntity(id: 1, name: 'Brand B', image: AppImages.brand_icon),
    BrandEntity(id: 0, name: 'Brand A', image: AppImages.brand_icon),
    BrandEntity(id: 1, name: 'Brand B', image: AppImages.brand_icon),
  ];
}

List<CarEntity> dummyDataCars() {
  return [
    CarEntity(
      id: 1,
      name: 'Toyota Camry',
          
      averageRate: 4.5,
      location: LocationEntity(name: 'New York', id: 1, lat: 22, lng: 44),
      seatingCapacity: 5,
      isForRent: true,
      dailyRent: 70.0, 
      firstImage: '', 
      images: [], 
      description: '', 
      carType: '', 
      brand: BrandEntity(id: 1, name: 'Toyota', image: 'https://example.com/images/toyota_camry.jpg',), 
      color: ColorEntity(id: 1, name: 'Red', hexValue: '', ),
      carFeatures: [], 
      isForPay: true, 
      availableToBook: true, 
      reviews: [],
    ),
    CarEntity(
      id: 2,
      name: 'Honda Accord',
      
      averageRate: 4.2,
      location: LocationEntity(name: 'Los Angeles', id: 2, lat: 33, lng: 44),
      seatingCapacity: 5,
      isForRent: true,
      dailyRent: 65.0, 
      firstImage: '', 
      images: [], 
      description: '', 
      carType: '', 
      brand: BrandEntity(id: 2, name: 'Honda', image: 'https://example.com/images/honda_accord.jpg',), 
      color: ColorEntity(id: 2, name: 'Blue', hexValue: '', ),
      carFeatures: [], 
      isForPay: true, 
      availableToBook: true, 
      reviews: [],
    ),
    CarEntity(
      id: 1,
      name: 'Toyota Camry',
          
      averageRate: 4.5,
      location: LocationEntity(name: 'New York', id: 1, lat: 22, lng: 44),
      seatingCapacity: 5,
      isForRent: true,
      dailyRent: 70.0, 
      firstImage: '', 
      images: [], 
      description: '', 
      carType: '', 
      brand: BrandEntity(id: 1, name: 'Toyota', image: 'https://example.com/images/toyota_camry.jpg',), 
      color: ColorEntity(id: 1, name: 'Red', hexValue: '', ),
      carFeatures: [], 
      isForPay: true, 
      availableToBook: true, 
      reviews: [],
    ),
    CarEntity(
      id: 2,
      name: 'Honda Accord',
      
      averageRate: 4.2,
      location: LocationEntity(name: 'Los Angeles', id: 2, lat: 33, lng: 44),
      seatingCapacity: 5,
      isForRent: true,
      dailyRent: 65.0, 
      firstImage: '', 
      images: [], 
      description: '', 
      carType: '', 
      brand: BrandEntity(id: 2, name: 'Honda', image: 'https://example.com/images/honda_accord.jpg',), 
      color: ColorEntity(id: 2, name: 'Blue', hexValue: '', ),
      carFeatures: [], 
      isForPay: true, 
      availableToBook: true, 
      reviews: [],
    ),
    CarEntity(
      id: 1,
      name: 'Toyota Camry',
          
      averageRate: 4.5,
      location: LocationEntity(name: 'New York', id: 1, lat: 22, lng: 44),
      seatingCapacity: 5,
      isForRent: true,
      dailyRent: 70.0, 
      firstImage: '', 
      images: [], 
      description: '', 
      carType: '', 
      brand: BrandEntity(id: 1, name: 'Toyota', image: 'https://example.com/images/toyota_camry.jpg',), 
      color: ColorEntity(id: 1, name: 'Red', hexValue: '', ),
      carFeatures: [], 
      isForPay: true, 
      availableToBook: true, 
      reviews: [],
    ),
    CarEntity(
      id: 2,
      name: 'Honda Accord',
      
      averageRate: 4.2,
      location: LocationEntity(name: 'Los Angeles', id: 2, lat: 33, lng: 44),
      seatingCapacity: 5,
      isForRent: true,
      dailyRent: 65.0, 
      firstImage: '', 
      images: [], 
      description: '', 
      carType: '', 
      brand: BrandEntity(id: 2, name: 'Honda', image: 'https://example.com/images/honda_accord.jpg',), 
      color: ColorEntity(id: 2, name: 'Blue', hexValue: '', ),
      carFeatures: [], 
      isForPay: true, 
      availableToBook: true, 
      reviews: [],
    ),
  ];
}

}