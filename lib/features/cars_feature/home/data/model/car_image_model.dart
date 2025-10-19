
import 'package:car_app/core/shared/car_image_entity.dart';

class CarImageModel extends CarImageEntity {
  const CarImageModel({
    required super.id,
    required super.image,
  });

  factory CarImageModel.fromJson(Map<String, dynamic> json) {
    return CarImageModel(
      id: json['id'] as int,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}