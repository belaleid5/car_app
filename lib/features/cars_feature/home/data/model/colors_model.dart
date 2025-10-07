import 'package:car_app/features/cars_feature/home/domain/entity/color_entity.dart';

class ColorModel extends ColorEntity {
  ColorModel({
    required super.id,
    required super.name,
    required super.hexValue,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      hexValue: json['hex_value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hex_value': hexValue,
    };
  }
}