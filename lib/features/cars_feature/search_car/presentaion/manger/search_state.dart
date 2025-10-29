part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.allCars,
    this.message,
    this.responsePaginationSearchCars,
    this.requestSearchCars,
    this.appStatus = AppStatus.initial,
  });

  final PaginatedSearchCarsEntity? responsePaginationSearchCars;
  final List<PaginatedSearchCarsEntity>? allCars;
  final SearchCarRequestEntity? requestSearchCars;
  final AppStatus appStatus;
  final String ? message;

  SearchState copyWith({
    PaginatedSearchCarsEntity? responsePaginationSearchCars,
    SearchCarRequestEntity? requestSearchCars,
    AppStatus? appStatus,
    String? message,
    List<PaginatedSearchCarsEntity>? allCars,
  }) {
    return SearchState(
      message: message ?? this.message,
      responsePaginationSearchCars: responsePaginationSearchCars ?? this.responsePaginationSearchCars,
      requestSearchCars: requestSearchCars ?? this.requestSearchCars,
      appStatus: appStatus ?? this.appStatus,
      allCars: allCars ?? allCars,
    );
  }

  @override
  List<Object?> get props => [
    allCars,
    responsePaginationSearchCars,
    requestSearchCars,
    appStatus,
    message,
  ];
}


