import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/login_entity.dart';
import 'package:car_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/forget_password_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth/domain/use_cases/check_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/refresh_tokens_params.dart';
import 'package:car_app/features/auth/domain/use_cases/register_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/save_tokens_params.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final CheckAuthUseCase checkAuthUseCase;
  final GetTokensUseCase getTokensUseCase;
  final SaveTokensUseCase saveTokensUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  AuthCubit({
    required this.forgetPasswordUseCase,

    required this.checkAuthUseCase,
    required this.getTokensUseCase,
    required this.saveTokensUseCase,
    required this.refreshTokenUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
    required this.loginUseCase,
    required this.resetPasswordUseCase,
  }) : super(const AuthState());

  Future<void> register(RegisterRequestEntity request) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await registerUseCase(
      RegisterParams(registerRequest: request),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (response) async =>
          _handleAuthSuccess(response.tokens, "Register success"),
    );
  }

  Future<void> login(LoginRequestEntity request) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await loginUseCase(request);

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (response) async => _handleAuthSuccess(response.tokens, "Login success"),
    );
  }

  Future<void> checkAuth() async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await checkAuthUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (isAuthenticated) => emit(
        state.copyWith(
          status: isAuthenticated ? AppStatus.success : AppStatus.empty,
        ),
      ),
    );
  }

  Future<void> getTokens() async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await getTokensUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (tokens) =>
          emit(state.copyWith(status: AppStatus.success, tokens: tokens)),
    );
  }

  Future<void> saveTokens(AuthTokensEntity tokens) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await saveTokensUseCase(SaveTokensParams(tokens: tokens));
    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (_) => emit(state.copyWith(status: AppStatus.success, tokens: tokens)),
    );
  }

  Future<void> refreshToken(String refreshToken) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await refreshTokenUseCase(
      RefreshTokenParams(refreshToken: refreshToken),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (tokens) =>
          emit(state.copyWith(status: AppStatus.success, tokens: tokens)),
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await logoutUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (_) => emit(const AuthState(status: AppStatus.empty, tokens: null)),
    );
  }




 
Future<void> forgetPassword(ForgetPasswordRequestEntity request) async {
  emit(state.copyWith(status: AppStatus.loading));
  final result = await forgetPasswordUseCase(request);

  result.fold(
    (failure) => emit(
      state.copyWith(status: AppStatus.failure, message: failure.message),
    ),
    (response) => emit(
      state.copyWith(
        status: AppStatus.success,
        message: response.message,
        confirmPasswordResponse: response, // أو resetPasswordResponse حسب اسم الـ field في AuthState
      ),
    ),
  );
}



  Future<void> resetPassword(ResetRequestPasswordEntity request) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await resetPasswordUseCase(request);

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (response) => emit(
        state.copyWith(
          status: AppStatus.success,
          message: response.message,
        ),
      ),
    );
  }

  Future<void> _handleAuthSuccess(
    AuthTokensEntity tokens,
    String message,
  ) async {
    await saveTokensUseCase(SaveTokensParams(tokens: tokens));
    emit(
      state.copyWith(
        status: AppStatus.success,
        tokens: tokens,
        message: message,
      ),
    );
  }
}
