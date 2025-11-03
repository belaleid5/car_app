part of 'search_cubit.dart';

class SearchState extends Equatable {
  final int currentPage;
  final List<CarEntity>? allCars;
  final PaginationResponseSearchEntity? responseSearchCars;
  final SearchCarRequestEntity? requestSearchCars;
  final AppStatus appStatus;
  final String? message;
  final CarFilterEntity? currentFilter;

  const SearchState({
    this.currentPage = 1,
    this.allCars,
    this.message,
    this.responseSearchCars,
    this.requestSearchCars,
    this.appStatus = AppStatus.initial,
    this.currentFilter,
  });

  // ✅ كلهم CarEntity
  List<CarEntity> get cars {
    if (responseSearchCars != null && responseSearchCars!.cars.isNotEmpty) {
      // حوّل CarSearchEntityResponse لـ CarEntity
      return responseSearchCars!.cars.map((car) {
        // لو CarSearchEntityResponse extends CarEntity
        return car as CarEntity;
      }).toList();
    }
    return allCars ?? [];
  }

  bool get hasNextPage => responseSearchCars?.hasNextPage ?? false;
  bool get hasPreviousPage => responseSearchCars?.hasPreviousPage ?? false;
  int get totalPages => responseSearchCars?.totalPages ?? 0;
  int get totalItems => responseSearchCars?.totalItems ?? 0;
  bool get hasCars => cars.isNotEmpty;
  bool get isLoading => appStatus == AppStatus.loading;
  bool get isSuccess => appStatus == AppStatus.success;
  bool get isFailure => appStatus == AppStatus.failure;
  bool get isInitial => appStatus == AppStatus.initial;

  SearchState copyWith({
    List<CarEntity>? allCars,
    PaginationResponseSearchEntity? responseSearchCars,
    SearchCarRequestEntity? requestSearchCars,
    AppStatus? appStatus,
    String? message,
    int? currentPage,
    CarFilterEntity? currentFilter,
  }) {
    return SearchState(
      message: message ?? this.message,
      responseSearchCars: responseSearchCars ?? this.responseSearchCars,
      requestSearchCars: requestSearchCars ?? this.requestSearchCars,
      appStatus: appStatus ?? this.appStatus,
      allCars: allCars ?? this.allCars,
      currentPage: currentPage ?? this.currentPage,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  @override
  List<Object?> get props => [
        allCars,
        responseSearchCars,
        requestSearchCars,
        appStatus,
        message,
        currentPage,
        currentFilter,
      ];
}