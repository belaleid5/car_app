import 'package:car_app/features/cars_feature/search_car/domain/entities/pagintaion_links_search_car_entity.dart';

class PaginationLinksModel extends PaginationLinksEntity {
  const PaginationLinksModel({
    super.first,
    super.last,
    super.prev,
    super.next,
  });

  factory PaginationLinksModel.fromJson(Map<String, dynamic> json) {
    return PaginationLinksModel(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}