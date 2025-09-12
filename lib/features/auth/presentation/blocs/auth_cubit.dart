import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/login_entity.dart';
import 'package:car_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:car_app/features/auth/domain/use_cases/check_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/refresh_tokens_params.dart';
import 'package:car_app/features/auth/domain/use_cases/register_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/save_tokens_params.dart';
import 'package:car_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthCubit extends Cubit<AuthState> {
  final CheckAuthUseCase checkAuthUseCase;
  final GetTokensUseCase getTokensUseCase;
  final SaveTokensUseCase saveTokensUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase; // ✅ أضفنا الـ LoginUseCase

  AuthCubit({
    required this.checkAuthUseCase,
    required this.getTokensUseCase,
    required this.saveTokensUseCase,
    required this.refreshTokenUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
    required this.loginUseCase, // ✅ هنا كمان
  }) : super(const AuthState());

  /// 🔹 Register
  Future<void> register(RegisterRequestEntity request) async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await registerUseCase(RegisterParams(registerRequest: request));

    result.fold(
      (failure) => emit(state.copyWith(
        status: AppStatus.failure,
        message: failure.message,
      )),
      (response) async {
        await saveTokensUseCase(
          SaveTokensParams(tokens: response.tokens),
        );

        emit(state.copyWith(
          status: AppStatus.success,
          tokens: response.tokens,
          message: "Register success",
        ));
      },
    );
  }

  /// 🔹 Login
  Future<void> login(LoginRequestEntity request) async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await loginUseCase(LoginRequestEntity( email:request.email, password: request.password));

    result.fold(
      (failure) => emit(state.copyWith(
        status: AppStatus.failure,
        message: failure.message,
      )),
      (response) async {
        await saveTokensUseCase(
          SaveTokensParams(tokens: response.tokens),
        );

        emit(state.copyWith(
          status: AppStatus.success,
          tokens: response.tokens,
          message: "Login success",
        ));
      },
    );
  }

  /// Check if user is authenticated
  Future<void> checkAuth() async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await checkAuthUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: AppStatus.failure, message: failure.message)),
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(state.copyWith(status: AppStatus.success));
        } else {
          emit(state.copyWith(status: AppStatus.empty));
        }
      },
    );
  }

  /// Get stored tokens
  Future<void> getTokens() async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await getTokensUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: AppStatus.failure, message: failure.message)),
      (tokens) => emit(state.copyWith(status: AppStatus.success, tokens: tokens)),
    );
  }

  /// Save tokens locally
  Future<void> saveTokens(AuthTokensEntity tokens) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await saveTokensUseCase(SaveTokensParams(tokens: tokens));
    result.fold(
      (failure) => emit(state.copyWith(status: AppStatus.failure, message: failure.message)),
      (_) => emit(state.copyWith(status: AppStatus.success, tokens: tokens)),
    );
  }

  /// Refresh tokens
  Future<void> refreshToken(String refreshToken) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await refreshTokenUseCase(RefreshTokenParams(refreshToken: refreshToken));
    result.fold(
      (failure) => emit(state.copyWith(status: AppStatus.failure, message: failure.message)),
      (tokens) => emit(state.copyWith(status: AppStatus.success, tokens: tokens)),
    );
  }

  /// Logout
  Future<void> logout() async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await logoutUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: AppStatus.failure, message: failure.message)),
      (_) => emit(const AuthState(status: AppStatus.empty, tokens: null)),
    );
  }
}
