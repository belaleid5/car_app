import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:car_app/features/auth/domain/entities/pagination_entity.dart';

class LocationPageEntity {
  final List<LocationEntity> locations;
  final PaginationEntity pagination;

  const LocationPageEntity({
    required this.locations,
    required this.pagination,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationPageEntity &&
        other.locations == locations &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => locations.hashCode ^ pagination.hashCode;

  @override
  String toString() {
    return 'LocationPageEntity(locations: ${locations.length} items, pagination: $pagination)';
  }
}
