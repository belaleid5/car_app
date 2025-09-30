import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/home/domain/usecase/get_brands_usecase.dart';
import 'package:car_app/features/home/presentaion/manger/hoem_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeCubit extends Cubit<HomeState> {
  final GetBrandsUseCase getBrands;

  HomeCubit({required this.getBrands}) : super(const HomeState());

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
}
