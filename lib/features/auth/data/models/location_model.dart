import 'dart:convert';

import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';

class LocationModel {
  final int id;
  final String name;
  final double lat;
  final double lng;

  const LocationModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });

  /// Convert from JSON to LocationModel
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  /// Convert from LocationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }

  /// Convert from LocationModel to LocationEntity
  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
      latitude: lat,
      longitude: lng,
    );
  }

  /// Convert from LocationEntity to LocationModel
  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      name: entity.name,
      lat: entity.latitude,
      lng: entity.longitude,
    );
  }

  /// Create a copy with new values
  LocationModel copyWith({
    int? id,
    String? name,
    double? lat,
    double? lng,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationModel &&
        other.id == id &&
        other.name == name &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lat.hashCode ^ lng.hashCode;
  }

  @override
  String toString() {
    return 'LocationModel(id: $id, name: $name, lat: $lat, lng: $lng)';
  }
}