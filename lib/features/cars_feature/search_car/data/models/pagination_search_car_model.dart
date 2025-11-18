import 'package:car_app/features/cars_feature/home/data/model/pagination_meta_model.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/pagination_links_model.dart';
import 'package:car_app/features/cars_feature/search_car/data/models/search_car_reponse_model.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/paginated_search_car_entity.dart';

class PaginatedSearchCarsModel extends PaginatedSearchCarsEntity {
  const PaginatedSearchCarsModel({
    required super.cars,
    required super.links,
    required super.meta,
    required super.hasNextPage,
    required super.hasPreviousPage,
  });

  factory PaginatedSearchCarsModel.fromJson(Map<String, dynamic> json) {
    final meta = PaginationMetaModel.fromJson(json['meta'] as Map<String, dynamic>);
    final links = PaginationLinksModel.fromJson(json['links'] as Map<String, dynamic>);

    return PaginatedSearchCarsModel(
      cars: (json['data'] as List<dynamic>)
          .map((e) => SearchCarResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(), // ✅ شيل الـ cast أحسن
      links: links,
      meta: meta,
      hasNextPage: meta.currentPage < meta.lastPage,
      hasPreviousPage: meta.currentPage > 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': cars.map((e) => (e as SearchCarResponseModel).toJson()).toList(),
      'links': (links as PaginationLinksModel).toJson(),
      'meta': (meta as PaginationMetaModel).toJson(),
    };
  }
}