import 'package:car_app/core/network/network_info.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/core/services/services_sharedprefrences.dart';
import 'package:car_app/features/auth_feature/data/data_sources/local_datasource.dart';
import 'package:car_app/features/auth_feature/data/data_sources/location_local_datasource.dart';
import 'package:car_app/features/auth_feature/data/data_sources/remote_data_source.dart';
import 'package:car_app/features/auth_feature/data/repositories_impl/auth_repo_imp.dart';
import 'package:car_app/features/auth_feature/data/repositories_impl/location_repo_imp.dart';
import 'package:car_app/features/auth_feature/domain/repositories/auth_repo.dart';
import 'package:car_app/features/auth_feature/domain/repositories/location_repo.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/check_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/forget_password_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/get_location-usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/get_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/login_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/logout_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/refresh_tokens_params.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/register_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/request_code_verify_phone_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/request_confirm_code_phone_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/reset_password_usecase.dart';
import 'package:car_app/features/auth_feature/domain/use_cases/save_tokens_params.dart';
import 'package:car_app/features/auth_feature/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/data/remote_data_source/car_remote_data_source.dart';
import 'package:car_app/features/cars_feature/car_details/data/repo_imp/car_imp.dart';
import 'package:car_app/features/cars_feature/car_details/domain/repo/car_details_repo.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_all_cars_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_cars-by_id_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_cars_brand_by_id_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/get_cars_review-usecase.dart';
import 'package:car_app/features/cars_feature/car_details/domain/usecase/search_cars_usecase.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_cubit.dart';
import 'package:car_app/features/cars_feature/home/data/datasource/local_data_source_cars.dart';
import 'package:car_app/features/cars_feature/home/data/datasource/remote_data_source.dart';
import 'package:car_app/features/cars_feature/home/data/repo_imp.dart/home_repo_imp.dart';
import 'package:car_app/features/cars_feature/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/cars_feature/home/domain/usecase/best_cars_usecase.dart';
import 'package:car_app/features/cars_feature/home/domain/usecase/get_brands_usecase.dart';
import 'package:car_app/features/cars_feature/home/domain/usecase/get_nearset_usecase.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // ==================== Core ====================
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  // ✅ Register DioClient نفسها (مش بس الـ dio)
  sl.registerLazySingleton<DioClient>(() => DioClient.instance);
  
  // Register Dio (من DioClient)
  sl.registerLazySingleton(() => DioClient.instance.dio);
  
  sl.registerLazySingleton<CarsLocalDataSource>(
    () => CarsLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesServiceImpl(
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  // ==================== Auth ====================
  // Auth Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Auth UseCases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  sl.registerLazySingleton(() => GetTokensUseCase(sl()));
  sl.registerLazySingleton(() => SaveTokensUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => RequestCodeVerifyPhoneUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => RequestConfirmCodePhoneUseCase(authRepo: sl()));

  // Location Data Sources
  sl.registerLazySingleton<LocationsRemoteDataSource>(
    () => LocationsRemoteDataSourceImpl(dio: sl()),
  );

  // Location Repository
  sl.registerLazySingleton<LocationsRepository>(
    () => LocationsRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Location UseCases
  sl.registerLazySingleton(() => GetLocationsUseCase(sl()));

  // Auth Cubit
  sl.registerFactory(
    () => AuthCubit(
      resetPasswordUseCase: sl(),
      checkAuthUseCase: sl(),
      getTokensUseCase: sl(),
      saveTokensUseCase: sl(),
      refreshTokenUseCase: sl(),
      logoutUseCase: sl(),
      registerUseCase: sl(),
      loginUseCase: sl(),
      forgetPasswordUseCase: sl(),
      getLocationsUseCase: sl(), 
      requestCodeVerifyPhoneUseCase: sl(), 
      confirmCodePhoneUseCase: sl(), 
    ),
  );

  // ==================== Home ====================
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dioClient: sl<DioClient>()), // ✅ استخدم sl<DioClient>()
  );

  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl<HomeRemoteDataSource>(), 
      localDataSource: sl(), 
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetBrandsUseCase(homeRepo: sl<HomeRepo>()));
  sl.registerLazySingleton(() => GetBestCarsUseCase(sl()));
  sl.registerLazySingleton(() => GetNearestCarsUseCase(sl()));

  sl.registerFactory(
    () => HomeCubit(
      getBrandsUseCase: sl<GetBrandsUseCase>(), 
      getBestCarsUseCase: sl<GetBestCarsUseCase>(), 
      getNearestCarsUseCase: sl(), 
    ),
  );

  // ==================== Car Details ====================
  // Data Sources
  sl.registerLazySingleton<CarRemoteDataSource>(
    () => CarRemoteDataSourceImpl(
      dio: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetCarByIdUseCase(sl()));
  sl.registerLazySingleton(() => SearchCarsUseCase(sl()));
  sl.registerLazySingleton(() => GetCarsByBrandUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCarsUseCase(sl()));
  sl.registerLazySingleton(() => GetCarsReviewUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => CarCubit(
      getCarByIdUseCase: sl(),
      searchCarsUseCase: sl(),
      getCarsByBrandUseCase: sl(),
      getAllCarsUseCase: sl(), getCarsByReviewUseCase: sl(),
    ),
  );
}