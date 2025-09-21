class LocationEntity {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationEntity &&
        other.id == id &&
        other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }

  @override
  String toString() {
    return 'LocationEntity(id: $id, name: $name, latitude: $latitude, longitude: $longitude)';
  }
}