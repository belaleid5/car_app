import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/paginated_car_entity.dart';
import 'package:car_app/core/shared/review_entity.dart';
import 'package:equatable/equatable.dart';

class ReviewsState extends Equatable {
  final AppStatus status;
  final ReviewEntity? reviews;

  final List<ReviewEntity> ?allReview;

  final CarEntity? selectedCar;
  
  final PaginationMetaEntity? meta;
  final String? errorMessage;
  final bool hasReachedMax;

  const ReviewsState({
    this.allReview,
    this.selectedCar,
    this.status = AppStatus.initial,
    this.reviews, // ← null في البداية
    this.meta,
    this.errorMessage,
    this.hasReachedMax = false,
  });

  ReviewsState copyWith({
    List<ReviewEntity>?allReview,
    AppStatus? status,
    ReviewEntity? reviews, // ← مراجعة واحدة
    PaginationMetaEntity? meta,
    String? errorMessage,
    bool? hasReachedMax,
    CarEntity? selectedCar,
  }) {
    return ReviewsState(
      allReview: allReview,
      selectedCar: selectedCar ?? this.selectedCar,
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      meta: meta ?? this.meta,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        allReview,
        status,
        reviews,
        selectedCar,
        meta,
        errorMessage,
        hasReachedMax,
      ];
}
