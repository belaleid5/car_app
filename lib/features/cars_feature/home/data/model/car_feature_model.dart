import 'package:car_app/features/cars_feature/home/domain/entity/car_features.dart';

class CarFeatureModel extends CarFeatureEntity {
  const CarFeatureModel({
    required super.id,
    required super.name,
    required super.value,
    required super.image,
  });

  factory CarFeatureModel.fromJson(Map<String, dynamic> json) {
    return CarFeatureModel(
      id: json['id'] as int,
      name: json['name'] as String,
      value: json['value'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'image': image,
    };
  }
}
