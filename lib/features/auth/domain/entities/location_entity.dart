import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int id;
  final String name;
  final double lat;
  final double lng;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props => [id, name, lat, lng];
}
