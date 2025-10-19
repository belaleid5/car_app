import 'package:car_app/features/cars_feature/home/domain/entity/paginated_car_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/pagintaion_links_search_car_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/search_car_request_entity.dart';
import 'package:equatable/equatable.dart';

class PaginatedSearchCarsEntity extends Equatable {
  final List<SearchCarRequestEntity> cars;
  final PaginationLinksEntity links;
  final PaginationMetaEntity meta;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginatedSearchCarsEntity({
    required this.cars,
    required this.links,
    required this.meta,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  List<Object?> get props => [
        cars,
        links,
        meta,
        hasNextPage,
        hasPreviousPage,
      ];
}
