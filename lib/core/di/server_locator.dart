import 'package:car_app/core/network/network_info.dart';
import 'package:car_app/core/network/dio_client.dart';
import 'package:car_app/features/auth/data/data_sources/local_datasource.dart';
import 'package:car_app/features/auth/data/data_sources/remote_data_source.dart';
import 'package:car_app/features/auth/data/repositories_impl/auth_repo_imp.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:car_app/features/auth/domain/use_cases/check_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/refresh_tokens_params.dart';
import 'package:car_app/features/auth/domain/use_cases/register_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/save_tokens_params.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencyInjection() async {
  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DioClient.instance);

  /// Core
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  /// Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// UseCases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  sl.registerLazySingleton(() => GetTokensUseCase(sl()));
  sl.registerLazySingleton(() => SaveTokensUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  /// Cubit
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
    ),
  );
}
