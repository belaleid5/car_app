
import 'package:car_app/features/cars_feature/home/data/model/cars_model.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/cars_reponse_entity.dart';

import 'pagination_meta_model.dart';

class CarsResponseModel extends CarsResponseEntity {
  const CarsResponseModel({
    required super.cars,
    required super.meta,
    super.nextPageUrl,
    super.prevPageUrl,
  });

  factory CarsResponseModel.fromJson(Map<String, dynamic> json) {
    return CarsResponseModel(
      cars: (json['data'] as List)
          .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PaginationMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      nextPageUrl: json['links']?['next'] as String?,
      prevPageUrl: json['links']?['prev'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': cars.map((e) => (e as CarModel).toJson()).toList(),
      'meta': (meta as PaginationMetaModel).toJson(),
      'links': {
        'next': nextPageUrl,
        'prev': prevPageUrl,
      },
    };
  }
}