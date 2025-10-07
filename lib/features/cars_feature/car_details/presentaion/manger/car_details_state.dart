// lib/features/cars/presentation/bloc/car_state.dart
import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/review_entity.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/enums/app_states.dart';

class CarState extends Equatable {
  // Car Details
  final AppStatus carDetailsStatus;
  final CarEntity? selectedCar;
  
  // Car List (Pagination)
  final AppStatus carListStatus;
  final List<CarEntity> cars;

  final int currentPage;
  final bool hasReachedMax;
  
  // Car Search
  final AppStatus searchStatus;
  final List<CarEntity> searchResults;
  final String searchQuery;
  
  // Cars By Brand
  final AppStatus carsByBrandStatus;
  final List<CarEntity> carsByBrand;
  final int? selectedBrandId;
  

  // Cars By Review
  final AppStatus carsByReviewStatus;
  final  ReviewEntity? carsByReview;
  final int? selectedReviewId;


  // Error Messages
  final String? carDetailsError;
  final String? carListError;
  final String? searchError;
  final String? carsByBrandError;

  const CarState({
    // Car Details
    this.carDetailsStatus = AppStatus.initial,
    this.selectedCar,
    
    // Car List
    this.carListStatus = AppStatus.initial,
    this.cars = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
    
    // Car Search
    this.searchStatus = AppStatus.initial,
    this.searchResults = const [],
    this.searchQuery = '',
    
    // Cars By Brand
    this.carsByBrandStatus = AppStatus.initial,
    this.carsByBrand = const [],
    this.selectedBrandId,
    
   // Cars By Review
    this.carsByReviewStatus = AppStatus.initial,
    this.carsByReview,
    this.selectedReviewId,

    // Error Messages
    this.carDetailsError,
    this.carListError,
    this.searchError,
    this.carsByBrandError,
  });

  // Helper getters for better readability
  bool get isLoadingCarDetails => carDetailsStatus == AppStatus.loading;
  bool get isLoadingCarList => carListStatus == AppStatus.loading;
  bool get isLoadingSearch => searchStatus == AppStatus.loading;
  bool get isLoadingCarsByBrand => carsByBrandStatus == AppStatus.loading;
  
  bool get hasCarDetailsError => carDetailsStatus == AppStatus.failure;
  bool get hasCarListError => carListStatus == AppStatus.failure;
  bool get hasSearchError => searchStatus == AppStatus.failure;
  bool get hasCarsByBrandError => carsByBrandStatus == AppStatus.failure;
  
  bool get hasSearchResults => searchResults.isNotEmpty;
  bool get isSearching => searchQuery.isNotEmpty;
  bool get hasCarsByBrand => carsByBrand.isNotEmpty;
  bool get hasCarsByReview => carsByReview != null;
  bool get hasSelectedBrand => selectedBrandId != null;

  CarState copyWith({
    // Car Details
    AppStatus? carDetailsStatus,
    CarEntity? selectedCar,
    bool clearSelectedCar = false,
    
    // Car List
    AppStatus? carListStatus,
    List<CarEntity>? cars,
    int? currentPage,
    bool? hasReachedMax,
    
    // Car Search
    AppStatus? searchStatus,
    List<CarEntity>? searchResults,
    String? searchQuery,
    
    // Cars By Brand
    AppStatus? carsByBrandStatus,
    List<CarEntity>? carsByBrand,
    int? selectedBrandId,
    bool clearSelectedBrandId = false,

    // Cars By Review
    AppStatus? carsByReviewStatus,
    ReviewEntity? carsByReview,
    int? selectedReviewId,
    bool clearSelectedReviewId = false,

    // Error Messages
    String? carDetailsError,
    String? carListError,
    String? searchError,
    String? carsByBrandError,
    bool clearCarDetailsError = false,
    bool clearCarListError = false,
    bool clearSearchError = false,
    bool clearCarsByBrandError = false,
  }) {
    return CarState(
      // Car Details
      carDetailsStatus: carDetailsStatus ?? this.carDetailsStatus,
      selectedCar: clearSelectedCar ? null : (selectedCar ?? this.selectedCar),
      
      // Car List
      carListStatus: carListStatus ?? this.carListStatus,
      cars: cars ?? this.cars,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      
      // Car Search
      searchStatus: searchStatus ?? this.searchStatus,
      searchResults: searchResults ?? this.searchResults,
      searchQuery: searchQuery ?? this.searchQuery,
      
      // Cars By Brand
      carsByBrandStatus: carsByBrandStatus ?? this.carsByBrandStatus,
      carsByBrand: carsByBrand ?? this.carsByBrand,
      selectedBrandId: clearSelectedBrandId ? null : (selectedBrandId ?? this.selectedBrandId),
      
      // Cars By Review
      carsByReviewStatus: carsByReviewStatus ?? this.carsByReviewStatus,
      carsByReview: carsByReview ?? this.carsByReview,
      selectedReviewId: clearSelectedReviewId ? null :
      (selectedReviewId ?? this.selectedReviewId),
    
    
      // Error Messages
      carDetailsError: clearCarDetailsError ? null : (carDetailsError ?? this.carDetailsError),
      carListError: clearCarListError ? null : (carListError ?? this.carListError),
      searchError: clearSearchError ? null : (searchError ?? this.searchError),
      carsByBrandError: clearCarsByBrandError ? null : (carsByBrandError ?? this.carsByBrandError),
    );
  }

  // Reset methods for convenience
  CarState resetCarDetails() {
    return copyWith(
      carDetailsStatus: AppStatus.initial,
      clearSelectedCar: true,
      clearCarDetailsError: true,
    );
  }

  CarState resetSearch() {
    return copyWith(
      searchStatus: AppStatus.initial,
      searchResults: const [],
      searchQuery: '',
      clearSearchError: true,
    );
  }

  CarState resetCarsByBrand() {
    return copyWith(
      carsByBrandStatus: AppStatus.initial,
      carsByBrand: const [],
      clearSelectedBrandId: true,
      clearCarsByBrandError: true,
    );
  }

  CarState resetCarList() {
    return copyWith(
      carListStatus: AppStatus.initial,
      cars: const [],
      currentPage: 1,
      hasReachedMax: false,
      clearCarListError: true,
    );
  }
  CarState resetCarsByReview() {
    return copyWith(
      carsByReviewStatus: AppStatus.initial,
      carsByReview: null,
      clearSelectedReviewId: true,
      clearCarsByBrandError: true,
    );
  }

  @override
  List<Object?> get props => [
        // Car Details
        carDetailsStatus,
        selectedCar,
        
        // Car List
        carListStatus,
        cars,
        currentPage,
        hasReachedMax,
        
        // Car Search
        searchStatus,
        searchResults,
        searchQuery,
        
        // Cars By Brand
        carsByBrandStatus,
        carsByBrand,
        selectedBrandId,
        
        // Cars By Review
        carsByReviewStatus,
        carsByReview,
        selectedReviewId,

        // Error Messages
        carDetailsError,
        carListError,
        searchError,
        carsByBrandError,
      ];

  @override
  String toString() {
    return '''CarState(
      carDetailsStatus: $carDetailsStatus,
      selectedCar: ${selectedCar?.id},
      carListStatus: $carListStatus,
      carsCount: ${cars.length},
      currentPage: $currentPage,
      hasReachedMax: $hasReachedMax,
      searchStatus: $searchStatus,
      searchResultsCount: ${searchResults.length},
      searchQuery: "$searchQuery",
      carsByBrandStatus: $carsByBrandStatus,
      carsByBrandCount: ${carsByBrand.length},
      selectedBrandId: $selectedBrandId,
      carsByReviewStatus: $carsByReviewStatus,
      carsByReviewCount: ${carsByReview != null ? 1 : 0},
      selectedReviewId: $selectedReviewId,
    )''';
  }
}

