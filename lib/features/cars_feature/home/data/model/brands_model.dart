import 'package:car_app/core/shared/brands_entity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  BrandEntity toEntity() {
    return BrandEntity(
      id: id,
      name: name,
      image: image,
    );
  }
}
