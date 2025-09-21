import 'package:car_app/features/auth/data/models/links_model.dart';
import 'package:car_app/features/auth/data/models/location_model.dart';
import 'package:car_app/features/auth/data/models/meta_model.dart';
import 'package:car_app/features/auth/domain/entities/location_page_entity.dart';

class LocationResponseModel {
  final List<LocationModel> data;
  final LinksModel links;
  final MetaModel meta;

  const LocationResponseModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) {
    return LocationResponseModel(
      data: (json['data'] as List<dynamic>)
          .map((item) => LocationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      links: LinksModel.fromJson(json['links'] as Map<String, dynamic>),
      meta: MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((location) => location.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }

  /// Convert to LocationPageEntity
  LocationPageEntity toEntity() {
    return LocationPageEntity(
      locations: data.map((model) => model.toEntity()).toList(),
      pagination: meta.toPaginationEntity(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationResponseModel &&
        other.data == data &&
        other.links == links &&
        other.meta == meta;
  }

  @override
  int get hashCode => data.hashCode ^ links.hashCode ^ meta.hashCode;

  @override
  String toString() {
    return 'LocationResponseModel(data: ${data.length} items, meta: $meta)';
  }
}