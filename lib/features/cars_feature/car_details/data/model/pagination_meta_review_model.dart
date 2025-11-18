import 'package:car_app/features/cars_feature/car_details/domain/entites/details_pagination_meta_entity.dart';

class PaginationReviewMetaModel extends DetailsPaginationMetaEntity {
  const PaginationReviewMetaModel({
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.total,
    required super.from,
    required super.to,
  });

  factory PaginationReviewMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationReviewMetaModel(
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
      perPage: json['per_page'] as int,
      total: json['total'] as int,
      from: json['from'] as int,
      to: json['to'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
      'from': from,
      'to': to,
    };
  }

  DetailsPaginationMetaEntity toEntity() {
    return DetailsPaginationMetaEntity(
      currentPage: currentPage,
      lastPage: lastPage,
      perPage: perPage,
      total: total,
      from: from,
      to: to,
    );
  }
}