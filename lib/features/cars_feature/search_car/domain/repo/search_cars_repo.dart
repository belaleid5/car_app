import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/pagination_repsone_search_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCarRepository {
  /// 🔍 البحث عن السيارات (يرجع List)
  Future<Either<Failure, List<CarSearchEntityResponse>>> searchRequest(
    SearchCarRequestEntity params,
  );

  /// 🚗 جلب كل السيارات (اختياري)
  Future<Either<Failure, List<CarSearchEntityResponse>>> getAllCars();
}
