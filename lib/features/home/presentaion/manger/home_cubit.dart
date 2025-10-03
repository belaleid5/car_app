// home_cubit.dart
import 'package:car_app/features/home/domain/usecase/best_cars_usecase.dart';
import 'package:car_app/features/home/domain/usecase/params/page_currenrt_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/app_states.dart';
import '../../domain/usecase/get_brands_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBrandsUseCase getBrandsUseCase;
  final GetBestCarsUseCase getBestCarsUseCase;

  HomeCubit({
    required this.getBrandsUseCase,
    required this.getBestCarsUseCase,
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

    final result = await getBrandsUseCase(PageCurrentCarsParams(page: state.currentPage));

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



  Future<void> fetchBestCars() async {
    print('🔄 Fetching best cars...');
    emit(state.copyWith(status: AppStatus.loading));

    final result = await getBestCarsUseCase(const PageCurrentCarsParams(page: 1));

    result.fold(
      (failure) {
        print('❌ ERROR: ${failure.message}');
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (carsResponse) {
        print('✅ SUCCESS: ${carsResponse.cars.length} cars loaded');

        // Debug each car
        for (var car in carsResponse.cars) {
          print('  🚗 ${car.name}');
          print('     First Image: ${car.firstImage}');
          print('     Images Count: ${car.images.length}');
          print('     Main Image URL: ${car.mainImageUrl}');
          print('     Location: ${car.location?.name ?? "null"}');
          print('     Seats: ${car.seatingCapacity}');
          print('     Daily Rent: ${car.dailyRent}');
        }

        emit(state.copyWith(
          status: AppStatus.success,
          bestCars: carsResponse.cars,
          hasReachedMax:
              carsResponse.meta.currentPage >= carsResponse.meta.lastPage,
        ));
      },
    );
  }

  Future<void> refreshBestCars() {
    emit(state.copyWith(
      bestCars: [],
      hasReachedMax: false,
    ));
    return fetchBestCars();
  }

  Future<void> loadMoreBestCars() async {
    if (state.hasReachedMax || state.status == AppStatus.loading) return;

    final currentPage = (state.bestCars.length ~/ 5) + 1;
    print('📄 Loading page $currentPage...');

    final result =
        await getBestCarsUseCase(PageCurrentCarsParams(page: currentPage));

    result.fold(
      (failure) {
        print('❌ Load more failed: ${failure.message}');
      },
      (carsResponse) {
        print('✅ Loaded ${carsResponse.cars.length} more cars');

        final updatedCars = [...state.bestCars, ...carsResponse.cars];

        emit(state.copyWith(
          status: AppStatus.success,
          bestCars: updatedCars,
          hasReachedMax:
              carsResponse.meta.currentPage >= carsResponse.meta.lastPage,
        ));
      },
    );
  }



  Future<void> fetchHomeData() async {
    emit(state.copyWith(status: AppStatus.loading));

    // Fetch brands
    final brandsResult = await getBrandsUseCase(PageCurrentCarsParams(page: 1));

    // ✅ FIX: Fetch best cars with params
    final carsResult =
        await getBestCarsUseCase(const PageCurrentCarsParams(page: 1));

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
