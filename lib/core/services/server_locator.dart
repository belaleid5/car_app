import 'package:car_app/core/network/network_info.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/core/services/services_sharedprefrences.dart';
import 'package:car_app/features/auth/data/data_sources/local_datasource.dart';
import 'package:car_app/features/auth/data/data_sources/location_local_datasource.dart';
import 'package:car_app/features/auth/data/data_sources/remote_data_source.dart';
import 'package:car_app/features/auth/data/repositories_impl/auth_repo_imp.dart';
import 'package:car_app/features/auth/data/repositories_impl/location_repo_imp.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:car_app/features/auth/domain/repositories/location_repo.dart';
import 'package:car_app/features/auth/domain/use_cases/check_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_location-usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/refresh_tokens_params.dart';
import 'package:car_app/features/auth/domain/use_cases/register_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/request_code_verify_phone_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/request_confirm_code_phone_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/save_tokens_params.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/home/data/datasource/local_data_source_cars.dart';
import 'package:car_app/features/home/data/datasource/remote_data_source.dart';
import 'package:car_app/features/home/data/repo_imp.dart/home_repo_imp.dart';
import 'package:car_app/features/home/domain/Repo/home_repo.dart';
import 'package:car_app/features/home/domain/usecase/best_cars_usecase.dart';
import 'package:car_app/features/home/domain/usecase/get_brands_usecase.dart';
import 'package:car_app/features/home/presentaion/manger/home_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
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

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dioClient: DioClient.instance),
  );

  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl<HomeRemoteDataSource>(), 
      localDataSource: sl(), 
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetBrandsUseCase(homeRepo:  sl<HomeRepo>()));
   sl.registerLazySingleton(() => GetBestCarsUseCase(sl()));

  sl.registerFactory(
    () => HomeCubit(
      getBrandsUseCase: sl<GetBrandsUseCase>(), 
      getBestCarsUseCase: sl<GetBestCarsUseCase>(), 
    ),
  );
}