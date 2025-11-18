
import 'package:car_app/features/cars_feature/search_car/domain/entities/paginated_items_links_entity.dart';

class PaginationLinkItemModel extends PaginationLinkItemEntity {
  const PaginationLinkItemModel({
    super.url,
    required super.label,
    required super.active,
  });

  factory PaginationLinkItemModel.fromJson(Map<String, dynamic> json) {
    return PaginationLinkItemModel(
      url: json['url'] as String?,
      label: json['label'] as String,
      active: json['active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

