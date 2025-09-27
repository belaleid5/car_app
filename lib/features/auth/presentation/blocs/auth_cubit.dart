import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/data/models/reset_password_model.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/confirm_code_phone_entity.dart';
import 'package:car_app/features/auth/domain/entities/forget_password_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/location_entity.dart';
import 'package:car_app/features/auth/domain/entities/login_entity.dart';
import 'package:car_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/request_verify_code_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';
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
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  // UseCases for Authentication
  final CheckAuthUseCase checkAuthUseCase;
  final GetTokensUseCase getTokensUseCase;
  final SaveTokensUseCase saveTokensUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final RequestCodeVerifyPhoneUseCase requestCodeVerifyPhoneUseCase;
  final RequestConfirmCodePhoneUseCase confirmCodePhoneUseCase;
  final GetLocationsUseCase getLocationsUseCase;

  AuthCubit({
    required this.confirmCodePhoneUseCase,
    required this.forgetPasswordUseCase,
    required this.checkAuthUseCase,
    required this.getTokensUseCase,
    required this.saveTokensUseCase,
    required this.refreshTokenUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
    required this.loginUseCase,
    required this.resetPasswordUseCase,
    required this.getLocationsUseCase,
    required this.requestCodeVerifyPhoneUseCase,
  }) : super(const AuthState());

  Future<void> register(RegisterRequestEntity request) async {
    emit(state.copyWith(status: AppStatus.registering));
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
      (_) => emit(const AuthState(status: AppStatus.empty)),
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
          confirmPasswordResponse: response,
        ),
      ),
    );
  }

  Future<void> resetPassword(ResetRequestPasswordEntity request) async {
  try {
    emit(state.copyWith(status: AppStatus.loading));
    
    final model = ResetPasswordModel.fromEntity(request);
    
    if (!model.isValid) {
      emit(state.copyWith(
        status: AppStatus.failure, 
        message: "Invalid data. Please check all fields."
      ));
      return;
    }
    
    print('🔥 Reset Password Request: ${model.toString()}');
    print('🔥 JSON Data: ${model.toJson()}');
    
    final result = await resetPasswordUseCase(model); // إرسال Model بدلاً من Entity
    
    result.fold(
      (failure) {
        print('❌ Reset Password Failed: ${failure.message}');
        emit(state.copyWith(
          status: AppStatus.failure, 
          message: failure.message
        ));
      },
      (response) {
        print('✅ Reset Password Success: ${response.message}');
        emit(state.copyWith(
          status: AppStatus.success, 
          message: response.message
        ));
      },
    );
  } catch (e, stackTrace) {
    print('💥 Reset Password Exception: $e');
    print('📍 Stack Trace: $stackTrace');
    emit(state.copyWith(
      status: AppStatus.failure, 
      message: "An unexpected error occurred. Please try again."
    ));
  }
}

  Future<void> sendVerifyCodePhone(RequestVerifyCodePhoneEntity request) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await requestCodeVerifyPhoneUseCase(request);

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (response) => emit(
        state.copyWith(
          status: AppStatus.success,
          message: response.message,
          responseVerifyCodePhone: response,
        ),
      ),
    );
  }


  Future<void> confirmCodePhone(ConfirmCodePhoneEntity request) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await confirmCodePhoneUseCase(request);

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

  //Locations methods
  Future<void> getLocations() async {
    if ((state.locations?.isNotEmpty ?? false) ||
        state.status == AppStatus.loading) {
      return;
    }

    emit(state.copyWith(status: AppStatus.loading));

    final result = await getLocationsUseCase(1);

    result.fold(
      (failure) {
        emit(
          state.copyWith(status: AppStatus.failure, message: failure.message),
        );
      },
      (newLocations) {
        emit(
          state.copyWith(
            status: AppStatus.success,
            locations: newLocations,
            hasReachedMax: true,
          ),
        );
      },
    );
  }

  Future<void> fetchAllLocations() async {
    if ((state.locations?.isNotEmpty ?? false) ||
        state.status == AppStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        status: AppStatus.loading,
        locations: [],
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    List<LocationEntity> allLocations = [];
    int currentPage = 1;
    bool hasMorePages = true;

    while (hasMorePages) {
      final result = await getLocationsUseCase(currentPage);

      result.fold(
        (failure) {
          hasMorePages = false;
        },
        (newLocations) {
          if (newLocations.isEmpty) {
            hasMorePages = false;
          } else {
            allLocations.addAll(newLocations);
            currentPage++;
          }
        },
      );
    }

    emit(
      state.copyWith(
        status: AppStatus.success,
        locations: allLocations,
        hasReachedMax: true,
      ),
    );
  }

  /// Resets only the location-related parts of the state.
  void resetLocationsState() {
    emit(
      state.copyWith(
        locations: [],
        currentPage: 1,
        hasReachedMax: false,
        status: AppStatus.initial,
      ),
    );
  }

  Future<void> getNextLocationsPage() async {
    // لا تطلب صفحة جديدة إذا كنا قد وصلنا للنهاية أو كنا نحمل بيانات بالفعل
    if (state.hasReachedMax || state.status == AppStatus.loadingMore) return;

    // إذا كانت هذه هي الصفحة الأولى، استخدم `loading`
    if (state.currentPage == 1) {
      emit(state.copyWith(status: AppStatus.loading));
    } else {
      // للصفحات التالية، استخدم `loadingMore`
      emit(state.copyWith(status: AppStatus.loadingMore));
    }

    final result = await getLocationsUseCase(state.currentPage);

    result.fold(
      (failure) {
        emit(
          state.copyWith(status: AppStatus.failure, message: failure.message),
        );
      },
      (newLocations) {
        final bool hasReachedMax = newLocations.isEmpty;

        emit(
          state.copyWith(
            status: AppStatus.success,
            locations: List.of(state.locations!)..addAll(newLocations),
            currentPage: state.currentPage + 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  /// Resets the location state for a fresh start.
  void refreshLocations() {
    // لا تقم بالطلب مرة أخرى إذا كانت البيانات محملة بالفعل
    if (state.locations?.isNotEmpty ?? false) return;

    emit(
      state.copyWith(
        locations: [],
        currentPage: 1,
        hasReachedMax: false,
        status: AppStatus.initial,
      ),
    );
    getNextLocationsPage();
  }
}
