import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_all_review_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_car_by_id_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_cars_review-usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/params/car_id_params.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetReviewsByCarIdUseCase getReviewsByCarIdUseCase;
  final GetCarByIdUseCase getCarByIdUseCase;
  final GetAllReviewsUseCase getAllReviewsUseCase;

  ReviewsCubit({
    required this.getAllReviewsUseCase,
    required this.getReviewsByCarIdUseCase,
    required this.getCarByIdUseCase,
  }) : super(const ReviewsState());

  int _currentCarId = 0;

Future<void> loadCarDetails(int carId) async {
    _currentCarId = carId;
    
    // 1. جلب السيارة أولاً
    await getCarById(carId);
    
    // 2. جلب المراجعة الأولى
    await getFirstReview(carId);
    
    // 3. جلب كل المراجعات
    await getAllReview(carId);
  }


  
  Future<void> getCarById(int carId) async {
    emit(state.copyWith(
      status: AppStatus.loading,
    ));

    final result = await getCarByIdUseCase(CarIdParams(carId: carId));

    result.fold(
      (failure) => emit(state.copyWith(
        status: AppStatus.failure,
        errorMessage: failure.message,
      )),
      (car) => emit(state.copyWith(
        status: AppStatus.success,
        selectedCar: car,
      )),
    );
  }

  /// جلب أول مراجعة فقط
  Future<void> getFirstReview(int carId) async {
    emit(state.copyWith(
      status: AppStatus.loading,
      reviews: null,
    ));

    _currentCarId = carId;

    final result = await getReviewsByCarIdUseCase(
      GetReviewsByCarIdParams(
        carId: carId,
        page: 1,
        perPage: 1, // نجيب واحدة بس
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AppStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (data) {
        if (data.reviews.isEmpty) {
          emit(state.copyWith(
            status: AppStatus.empty,
            reviews: null,
            meta: data.meta,
          ));
        } else {
          // خد أول مراجعة من الليستة
          emit(state.copyWith(
            status: AppStatus.success,
            reviews: data.reviews.first, // ✅ أول واحدة بس
            meta: data.meta,
          ));
        }
      },
    );
  }

Future<void> getAllReview(int carId) async {
  print('🚗 getAllReview called with carId: $carId');
  
  emit(state.copyWith(
    status: AppStatus.loading,
    allReview: null,
  ));

  _currentCarId = carId;

  final result = await getAllReviewsUseCase(
    CarIdParams(
      carId: carId,
      page: 1,
    )
  );

  result.fold(
    (failure) {
      print('❌ Failure: ${failure.message}');
      emit(state.copyWith(
        status: AppStatus.failure,
        errorMessage: failure.message,
      ));
    },
    (data) {
      print('✅ Success! Got ${data.reviews.length} reviews');
      
      if (data.reviews.isEmpty) {
        print('⚠️ Reviews list is empty');
        emit(state.copyWith(
          status: AppStatus.empty,
          allReview: [],
          meta: data.meta,
        ));
      } else {
        print('📋 Emitting ${data.reviews.length} reviews');
        emit(state.copyWith(
          status: AppStatus.success,
          allReview: data.reviews, // ✅ تأكد إن دي List<ReviewEntity>
          meta: data.meta,
        ));
      }
    },
  );
}


  /// إعادة المحاولة
  Future<void> retry() async {
    await getFirstReview(_currentCarId);
  }

  /// تحديث المراجعة
  Future<void> refreshReview() async {
    await getFirstReview(_currentCarId);
  }

  /// إعادة تعيين الحالة
  void reset() {
    _currentCarId = 0;
    emit(const ReviewsState());
  }
}







