import 'dart:convert';

import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/home/data/model/car_response_model.dart';
import 'package:car_app/features/home/data/model/cars_model.dart';
import 'package:car_app/features/home/data/model/pagination_meta_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CarsLocalDataSource {
  Future<CarsResponseModel> getCachedBestCars();
  Future<void> cacheBestCars(CarsResponseModel cars);

}


class CarsLocalDataSourceImpl implements CarsLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedBestCars = 'CACHED_BEST_CARS';
  static const String cachedCarPrefix = 'CACHED_CAR_';

  CarsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CarsResponseModel> getCachedBestCars() async {
    final jsonString = sharedPreferences.getString(cachedBestCars);
    if (jsonString != null) {
      return CarsResponseModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException('No cached data found');
    }
  }

  @override
  Future<void> cacheBestCars(CarsResponseModel cars) async {
    final jsonString = json.encode({
      'data': cars.cars.map((e) => (e as CarModel).toJson()).toList(),
      'links': {
        'next': cars.nextPageUrl,
        'prev': cars.prevPageUrl,
      },
      'meta': (cars.meta as PaginationMetaModel).toJson(),
    });
    await sharedPreferences.setString(cachedBestCars, jsonString);
  }


}