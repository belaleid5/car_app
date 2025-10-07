// lib/features/cars/presentation/bloc/car_cubit.dart
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_all_cars_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_cars-by_id_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_cars_brand_by_id_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_cars_review-usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/car_id_params.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/search_cars_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_app/core/enums/app_states.dart';


class CarCubit extends Cubit<CarState> {
  final GetCarByIdUseCase getCarByIdUseCase;
  final SearchCarsUseCase searchCarsUseCase;
  final GetCarsByBrandUseCase getCarsByBrandUseCase;
  final GetAllCarsUseCase getAllCarsUseCase;
  final GetCarsReviewUseCase getCarsByReviewUseCase;

  CarCubit({
    required this.getCarByIdUseCase,
    required this.searchCarsUseCase,
    required this.getCarsByBrandUseCase,
    required this.getAllCarsUseCase,
    required this.getCarsByReviewUseCase,
  }) : super(const CarState());

  // ==================== Car Details ====================
  /// Get car by ID
  Future<void> getCarById(int carId) async {
    emit(state.copyWith(
      carDetailsStatus: AppStatus.loading,
      clearCarDetailsError: true,
    ));

    final result = await getCarByIdUseCase(CarIdParams(carId: carId));

    result.fold(
      (failure) => emit(state.copyWith(
        carDetailsStatus: AppStatus.failure,
        carDetailsError: failure.message,
      )),
      (car) => emit(state.copyWith(
        carDetailsStatus: AppStatus.success,
        selectedCar: car,
      )),
    );
  }





    Future<void> getReviewCarById(int carId) async {
    emit(state.copyWith(
      carsByReviewStatus: AppStatus.loading,
      clearSelectedReviewId: true,

    ));

    final result = await getCarsByReviewUseCase(CarIdParams(carId: carId));

    result.fold(
      (failure) => emit(
        state.copyWith(
          carsByReviewStatus: AppStatus.failure,
          carDetailsError: failure.message,
        ),
      ),
      (review) => emit(state.copyWith(
        carsByReviewStatus: AppStatus.success,
        carsByReview: review,
      )),
    );
  }

  /// Clear selected car
  void clearSelectedCar() {
    emit(state.resetCarDetails());
  }

  // ==================== Car List (Pagination) ====================
  /// Get all cars with pagination
  Future<void> getAllCars({bool isRefresh = false}) async {
    // Prevent multiple calls
    if (state.hasReachedMax && !isRefresh) return;

    // If refresh, reset pagination
    if (isRefresh) {
      emit(state.resetCarList());
    }

    emit(state.copyWith(
      carListStatus: AppStatus.loading,
      clearCarListError: true,
    ));

    final result = await getAllCarsUseCase(
      PaginationParams(page: isRefresh ? 1 : state.currentPage),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        carListStatus: AppStatus.failure,
        carListError: failure.message,
      )),
      (newCars) {
        final updatedCars = isRefresh 
            ? newCars 
            : [...state.cars, ...newCars];
        
        emit(state.copyWith(
          carListStatus: AppStatus.success,
          cars: updatedCars,
          currentPage: state.currentPage + 1,
          hasReachedMax: newCars.isEmpty || newCars.length < 10, // Assuming 10 items per page
        ));
      },
    );
  }

  /// Load more cars
  Future<void> loadMoreCars() async {
    await getAllCars(isRefresh: false);
  }

  /// Refresh car list
  Future<void> refreshCarList() async {
    await getAllCars(isRefresh: true);
  }

  // ==================== Search Cars ====================
  /// Search cars by query
  Future<void> searchCars(String query) async {
    // Clear search if query is empty
    if (query.trim().isEmpty) {
      emit(state.resetSearch());
      return;
    }

    emit(state.copyWith(
      searchStatus: AppStatus.loading,
      searchQuery: query,
      clearSearchError: true,
    ));

    final result = await searchCarsUseCase(
      SearchCarsParams(query: query),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        searchStatus: AppStatus.failure,
        searchError: failure.message,
      )),
      (cars) => emit(state.copyWith(
        searchStatus: AppStatus.success,
        searchResults: cars,
      )),
    );
  }

  /// Clear search
  void clearSearch() {
    emit(state.resetSearch());
  }

  /// Debounced search (call this from UI with debouncing)
  void onSearchQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  // ==================== Cars By Brand ====================
  /// Get cars by brand ID
  Future<void> getCarsByBrand(int brandId) async {
    emit(state.copyWith(
      carsByBrandStatus: AppStatus.loading,
      selectedBrandId: brandId,
      clearCarsByBrandError: true,
    ));

    final result = await getCarsByBrandUseCase(
      BrandIdParams(brandId: brandId),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        carsByBrandStatus: AppStatus.failure,
        carsByBrandError: failure.message,
      )),
      (cars) => emit(state.copyWith(
        carsByBrandStatus: AppStatus.success,
        carsByBrand: cars,
      )),
    );
  }

  /// Clear cars by brand
  void clearCarsByBrand() {
    emit(state.resetCarsByBrand());
  }

  // ==================== Reset All ====================
  /// Reset all states
  void resetAll() {
    emit(const CarState());
  }

  // ==================== Utility Methods ====================
  /// Check if any operation is loading
  bool get isAnyLoading =>
      state.isLoadingCarDetails ||
      state.isLoadingCarList ||
      state.isLoadingSearch ||
      state.isLoadingCarsByBrand;

  /// Get total cars count
  int get totalCarsCount => state.cars.length;

  /// Get search results count
  int get searchResultsCount => state.searchResults.length;

  /// Get cars by brand count
  int get carsByBrandCount => state.carsByBrand.length;
}


