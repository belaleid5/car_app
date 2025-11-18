import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/review_details_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_car_deatils_car_by_id_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_review_car_by_id_car.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_review_cars_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/card_id_prams.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/deatils_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================
// DETAILS CUBIT - Fixed Version
// ============================================

class DetailsCubit extends Cubit<DetailsState> {
  final GetReviewsByCarIdUseCase _getReviewsByCarIdUseCase;
  final GetCarByIdUseCase _getCarByIdUseCase;

  DetailsCubit({
    required GetReviewsByCarIdUseCase getReviewsByCarIdUseCase,
    required GetCarByIdUseCase getCarByIdUseCase,
  })  : _getReviewsByCarIdUseCase = getReviewsByCarIdUseCase,
        _getCarByIdUseCase = getCarByIdUseCase,
        super(const DetailsState());

  int _currentCarId = 0;

  /// Load car details and reviews together
  Future<void> loadCarDetails(int carId) async {
    _currentCarId = carId;
    emit(state.copyWith(status: AppStatus.loading));

    // Step 1: Fetch car details
    final carResult = await _getCarByIdUseCase(CarIdParams(carId: carId));

    await carResult.fold(
      (failure) async {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (car) async {
        emit(state.copyWith(
          status: AppStatus.success,
          selectedCar: car,
        ));

        // Step 2: Fetch reviews after car is loaded
        await _loadReviews(carId);
      },
    );
  }

  /// Private method to load reviews
  Future<void> _loadReviews(int carId) async {
    final reviewsResult = await _getReviewsByCarIdUseCase(
      GetReviewsByCarIdParams(carId: carId, page: 1),
    );

    reviewsResult.fold(
      (failure) {
        // Don't override the success status if car is already loaded
        if (state.selectedCar != null) {
          emit(state.copyWith(
            status: AppStatus.success,
            allReviews: [],
            errorMessage: 'Reviews: ${failure.message}',
          ));
        } else {
          emit(state.copyWith(
            status: AppStatus.failure,
            errorMessage: failure.message,
          ));
        }
      },
      (paginatedReviews) {
        if (paginatedReviews.reviews.isEmpty) {
          emit(state.copyWith(
            status: AppStatus.empty,
            allReviews: [],
            meta: paginatedReviews.meta,
          ));
        } else {
          emit(state.copyWith(
            status: AppStatus.success,
            allReviews: paginatedReviews.reviews,
            meta: paginatedReviews.meta,
            hasReachedMax: !paginatedReviews.meta.hasNextPage,
          ));
        }
      },
    );
  }

  /// Load more reviews for pagination
  /// ✅ FIXED: Proper type casting for the list
  Future<void> loadMoreReviews() async {
    if (state.hasReachedMax || state.status == AppStatus.loading) {
      return;
    }

    final nextPage = (state.meta?.currentPage ?? 0) + 1;

    final reviewsResult = await _getReviewsByCarIdUseCase(
      GetReviewsByCarIdParams(
        carId: _currentCarId,
        page: nextPage,
      ),
    );

    reviewsResult.fold(
      (failure) {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (paginatedReviews) {
        // ✅ FIX: Create a properly typed list
        final List<ReviewDetailsEntity> updatedReviews = [
          ...(state.allReviews ?? []),
          ...paginatedReviews.reviews,
        ];

        emit(state.copyWith(
          status: AppStatus.success,
          allReviews: updatedReviews,
          meta: paginatedReviews.meta,
          hasReachedMax: !paginatedReviews.meta.hasNextPage,
        ));
      },
    );
  }

  /// Refresh only reviews
  Future<void> refreshReviews(int carId) async {
    _currentCarId = carId;
    await _loadReviews(carId);
  }

  /// Retry loading data
  Future<void> retry() async {
    if (_currentCarId > 0) {
      await loadCarDetails(_currentCarId);
    }
  }

  /// Reset state to initial
  void reset() {
    _currentCarId = 0;
    emit(const DetailsState());
  }
}

// ============================================
// ALTERNATIVE IMPLEMENTATION
// If you still have issues, use this version
// ============================================

class DetailsCubitAlternative extends Cubit<DetailsState> {
  final GetReviewsByCarIdUseCase _getReviewsByCarIdUseCase;
  final GetCarByIdUseCase _getCarByIdUseCase;

  DetailsCubitAlternative({
    required GetReviewsByCarIdUseCase getReviewsByCarIdUseCase,
    required GetCarByIdUseCase getCarByIdUseCase,
  })  : _getReviewsByCarIdUseCase = getReviewsByCarIdUseCase,
        _getCarByIdUseCase = getCarByIdUseCase,
        super(const DetailsState());

  int _currentCarId = 0;

  Future<void> loadCarDetails(int carId) async {
    _currentCarId = carId;
    emit(state.copyWith(status: AppStatus.loading));

    final carResult = await _getCarByIdUseCase(CarIdParams(carId: carId));

    await carResult.fold(
      (failure) async {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (car) async {
        emit(state.copyWith(
          status: AppStatus.success,
          selectedCar: car,
        ));

        await _loadReviews(carId);
      },
    );
  }

  Future<void> _loadReviews(int carId) async {
    final reviewsResult = await _getReviewsByCarIdUseCase(
      GetReviewsByCarIdParams(carId: carId, page: 1),
    );

    reviewsResult.fold(
      (failure) {
        if (state.selectedCar != null) {
          emit(state.copyWith(
            status: AppStatus.success,
            allReviews: <ReviewDetailsEntity>[], // ✅ Explicit type
            errorMessage: 'Reviews: ${failure.message}',
          ));
        } else {
          emit(state.copyWith(
            status: AppStatus.failure,
            errorMessage: failure.message,
          ));
        }
      },
      (paginatedReviews) {
        if (paginatedReviews.reviews.isEmpty) {
          emit(state.copyWith(
            status: AppStatus.empty,
            allReviews: <ReviewDetailsEntity>[], // ✅ Explicit type
            meta: paginatedReviews.meta,
          ));
        } else {
          emit(state.copyWith(
            status: AppStatus.success,
            allReviews: List<ReviewDetailsEntity>.from(paginatedReviews.reviews), // ✅ Explicit casting
            meta: paginatedReviews.meta,
            hasReachedMax: !paginatedReviews.meta.hasNextPage,
          ));
        }
      },
    );
  }

  Future<void> loadMoreReviews() async {
    if (state.hasReachedMax || state.status == AppStatus.loading) {
      return;
    }

    final currentReviews = state.allReviews ?? <ReviewDetailsEntity>[]; // ✅ Default to typed empty list
    final nextPage = (state.meta?.currentPage ?? 0) + 1;

    final reviewsResult = await _getReviewsByCarIdUseCase(
      GetReviewsByCarIdParams(
        carId: _currentCarId,
        page: nextPage,
      ),
    );

    reviewsResult.fold(
      (failure) {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (paginatedReviews) {
        // ✅ METHOD 1: Using List.from with explicit type
        final updatedReviews = List<ReviewDetailsEntity>.from(currentReviews)
          ..addAll(paginatedReviews.reviews);

        // ✅ METHOD 2: Using spread operator (alternative)
        // final updatedReviews = <ReviewDetailsEntity>[
        //   ...currentReviews,
        //   ...paginatedReviews.reviews,
        // ];

        emit(state.copyWith(
          status: AppStatus.success,
          allReviews: updatedReviews,
          meta: paginatedReviews.meta,
          hasReachedMax: !paginatedReviews.meta.hasNextPage,
        ));
      },
    );
  }

  Future<void> refreshReviews(int carId) async {
    _currentCarId = carId;
    
    // Reset reviews before loading
    emit(state.copyWith(
      allReviews: <ReviewDetailsEntity>[],
      hasReachedMax: false,
    ));
    
    await _loadReviews(carId);
  }

  Future<void> retry() async {
    if (_currentCarId > 0) {
      await loadCarDetails(_currentCarId);
    }
  }

  void reset() {
    _currentCarId = 0;
    emit(const DetailsState());
  }
}

// ============================================
// HELPER EXTENSION (Optional)
// Makes working with lists easier
// ============================================

extension ReviewListExtension on List<ReviewDetailsEntity> {
  List<ReviewDetailsEntity> addReviews(List<ReviewDetailsEntity> newReviews) {
    return List<ReviewDetailsEntity>.from(this)..addAll(newReviews);
  }
}

// Usage in Cubit:
// final updatedReviews = currentReviews.addReviews(paginatedReviews.reviews);