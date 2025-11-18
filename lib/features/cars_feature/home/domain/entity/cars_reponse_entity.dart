import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/paginated_car_entity.dart';
import 'package:equatable/equatable.dart';

class CarsSearchResponseEntity extends Equatable {
  final List<CarEntity> cars;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final PaginationMetaEntity meta;

  const CarsSearchResponseEntity({
    required this.cars,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.meta,
  });

  @override
  List<Object?> get props => [
        cars,
        nextPageUrl,
        prevPageUrl,
        meta,
      ];
}
