import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/car_filter.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/pagination_search_response_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/car_repsone_search_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/usecases/request_search_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final RequestSearchUseCase searchCarsUseCase;

  SearchCubit(this.searchCarsUseCase,)
      : super(const SearchState());

  Future<void> searchCars(SearchCarRequestEntity request) async {
    emit(state.copyWith(appStatus: AppStatus.loading));
    final result = await searchCarsUseCase(request);

    result.fold(
      (failure) => emit(
        state.copyWith(appStatus: AppStatus.failure, message: failure.message),
      ),
      (response) => emit(
        state.copyWith(
          appStatus: AppStatus.success,
          responseSearchCars: response,
        ),
      ),
    );
  }

  

  // ✅ NEW: Apply filter method
  Future<void> applyFilter(CarFilterEntity filter) async {
    emit(state.copyWith(
      appStatus: AppStatus.loading,
      currentFilter: filter,
    ));

    final searchRequest = filter.toSearchRequest();
    await searchCars(searchRequest);
  }

  // ✅ NEW: Clear filter method
  void clearFilter() {
    emit(state.copyWith(currentFilter: const CarFilterEntity()));
  }

  // ✅ NEW: Filter by brand
  void filterByBrand(int brandId) {
    final newFilter = (state.currentFilter ?? const CarFilterEntity())
        .copyWith(brandId: brandId);
    applyFilter(newFilter);
  }
}