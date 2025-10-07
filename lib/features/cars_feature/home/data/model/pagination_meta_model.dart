import 'package:car_app/features/cars_feature/home/domain/entity/paginated_car_entity.dart';

class PaginationMetaModel extends PaginationMetaEntity {
  const PaginationMetaModel({
    required super.currentPage,
    required super.from,
    required super.lastPage,
    required super.path,
    required super.perPage,
    required super.to,
    required super.total,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      currentPage: json['current_page'] as int,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      to: json['to'] as int,
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}