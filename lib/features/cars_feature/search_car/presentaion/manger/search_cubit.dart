import 'package:bloc/bloc.dart';
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/paginated_search_car_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/search_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/usecases/get_all_cars-usecase.dart';
import 'package:car_app/features/cars_feature/search_car/domain/usecases/search_car_usecase.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchCarUseCase searchCarsUseCase;
  final GetAllSearchCarsUseCase getAllCarsUseCase;

  SearchCubit(this.searchCarsUseCase, this.getAllCarsUseCase)
      : super(const SearchState());

  Future<void> searchCars(SearchCarRequestEntity request) async {
    emit(state.copyWith(appStatus: AppStatus.loading));
    final result = await searchCarsUseCase(request);

    result.fold(
      (failure) => emit(
        state.copyWith(appStatus: AppStatus.failure, message: failure.message),
      ),
      (response) async => emit(
        state.copyWith(
          appStatus: AppStatus.success,
          responsePaginationSearchCars: response,
        ),
      ),
    );
  }

  Future<void> getAllCars() async {
    emit(state.copyWith(appStatus: AppStatus.loading));
    final result = await getAllCarsUseCase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(appStatus: AppStatus.failure, message: failure.message),
      ),
      (response) async => emit(
        state.copyWith(
          appStatus: AppStatus.success,
          allCars: response,
        ),
      ),
    );
  }
}
