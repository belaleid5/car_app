import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/details_pagination_meta_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/review_details_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/paginated_car_entity.dart';
import 'package:equatable/equatable.dart';

class DetailsState extends Equatable {
  final AppStatus status;
  final CarEntity? selectedCar;
  final List<ReviewDetailsEntity>? allReviews;
  final DetailsPaginationMetaEntity? meta;
  final String? errorMessage;
  final bool hasReachedMax;

  const DetailsState({
    this.status = AppStatus.initial,
    this.selectedCar,
    this.allReviews,
    this.meta,
    this.errorMessage,
    this.hasReachedMax = false,
  });

  DetailsState copyWith({
    AppStatus? status,
    CarEntity? selectedCar,
    List<ReviewDetailsEntity>? allReviews,
    DetailsPaginationMetaEntity? meta,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return DetailsState(
      status: status ?? this.status,
      selectedCar: selectedCar ?? this.selectedCar,
      allReviews: allReviews ?? this.allReviews,
      meta: meta ?? this.meta,
      errorMessage: errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedCar,
        allReviews,
        meta,
        errorMessage,
        hasReachedMax,
      ];
}
