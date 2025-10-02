import 'package:car_app/features/home/data/model/cars_model.dart';
import 'package:car_app/features/home/data/model/pagination_meta_model.dart';
import 'package:car_app/features/home/domain/entity/cars_reponse_entity.dart';

class CarsResponseModel extends CarsResponseEntity {
  const CarsResponseModel({
    required super.cars,
    super.nextPageUrl,
    super.prevPageUrl,
    required super.meta,
  });

  factory CarsResponseModel.fromJson(Map<String, dynamic> json) {
    return CarsResponseModel(
      cars: (json['data'] as List)
          .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['links']['next'] as String?,
      prevPageUrl: json['links']['prev'] as String?,
      meta: PaginationMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }
}