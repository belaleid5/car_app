// home_cubit.dart
import 'package:car_app/features/home/domain/usecase/best_cars_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/app_states.dart';
import '../../domain/usecase/get_brands_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBrandsUseCase getBrands;
  final GetBestCarsUseCase getBestCars;

  HomeCubit({
    required this.getBrands,
    required this.getBestCars,
  }) : super(const HomeState());



  Future<void> fetchBrands({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(state.copyWith(
        status: AppStatus.loading,
        brands: [],
        currentPage: 1,
        hasReachedMax: false,
      ));
    } else if (state.hasReachedMax) {
      return;
    } else {
      emit(state.copyWith(status: AppStatus.loadingMore));
    }

    final result = await getBrands(BrandParams(page: state.currentPage));

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (brands) {
        final hasReachedMax = brands.isEmpty;

        emit(state.copyWith(
          status: AppStatus.success,
          brands: isRefresh ? brands : [...state.brands, ...brands],
          currentPage: state.currentPage + 1,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future<void> refreshBrands() async {
    await fetchBrands(isRefresh: true);
  }

  Future<void> loadMoreBrands() async {
    if (state.status != AppStatus.loadingMore && !state.hasReachedMax) {
      await fetchBrands();
    }
  }

 

  Future<void> fetchBestCars({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(state.copyWith(
        status: AppStatus.loading,
        bestCars: [],
        currentPage: 1,
        hasReachedMax: false,
      ));
    } else if (state.hasReachedMax) {
      return;
    } else {
      emit(state.copyWith(status: AppStatus.loadingMore));
    }

    final result = await getBestCars(page: state.currentPage);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (carsResponse) {
        final hasReachedMax = 
            carsResponse.meta.currentPage >= carsResponse.meta.lastPage;

        emit(state.copyWith(
          status: AppStatus.success,
          bestCars: isRefresh 
              ? carsResponse.cars 
              : [...state.bestCars, ...carsResponse.cars],
          carsMeta: carsResponse.meta,
          currentPage: state.currentPage + 1,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future<void> refreshBestCars() async {
    await fetchBestCars(isRefresh: true);
  }

  Future<void> loadMoreBestCars() async {
    if (state.status != AppStatus.loadingMore && !state.hasReachedMax) {
      await fetchBestCars();
    }
  }


  Future<void> fetchHomeData() async {
    emit(state.copyWith(status: AppStatus.loading));

    // Fetch brands
    final brandsResult = await getBrands(BrandParams(page: 1));
    
    // Fetch best cars
    final carsResult = await getBestCars(page: 1);

    brandsResult.fold(
      (failure) {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (brands) {
        carsResult.fold(
          (failure) {
            emit(state.copyWith(
              status: AppStatus.failure,
              errorMessage: failure.message,
              brands: brands, // Keep brands if cars failed
            ));
          },
          (carsResponse) {
            emit(state.copyWith(
              status: AppStatus.success,
              brands: brands,
              bestCars: carsResponse.cars,
              carsMeta: carsResponse.meta,
              currentPage: 2, // Next page
              hasReachedMax: 
                  carsResponse.meta.currentPage >= carsResponse.meta.lastPage,
            ));
          },
        );
      },
    );
  }

  Future<void> refreshHomeData() async {
    emit(state.copyWith(
      status: AppStatus.loading,
      brands: [],
      bestCars: [],
      currentPage: 1,
      hasReachedMax: false,
    ));
    await fetchHomeData();
  }
}