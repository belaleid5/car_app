import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/home/domain/entity/brands_entity.dart';
import 'package:dartz/dartz.dart';


abstract class HomeRepo {
  Future<Either<Failure, List<BrandEntity>>> getBrands({int page = 1});
}