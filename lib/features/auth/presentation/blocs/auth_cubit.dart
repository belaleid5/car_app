import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/forget_password_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/location_entity.dart';
import 'package:car_app/features/auth/domain/entities/login_entity.dart';
import 'package:car_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth/domain/use_cases/check_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_location-usecase.dart';
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

  final GetLocationsUseCase getLocationsUseCase;

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
    required this.getLocationsUseCase,
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
    emit(state.copyWith(status: AppStatus.loading));
    final result = await resetPasswordUseCase(request);

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (response) => emit(
        state.copyWith(status: AppStatus.success, message: response.message),
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


  Future<void> getLocations() async {
    if ((state.locations?.isNotEmpty ?? false) || state.status == AppStatus.loading) {
      return;
    }

    emit(state.copyWith(status: AppStatus.loading));

    final result = await getLocationsUseCase(1);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AppStatus.failure,
          message: failure.message,
        ));
      },
      (newLocations) {
        emit(state.copyWith(
          status: AppStatus.success,
          locations: newLocations,
          hasReachedMax: true, // نفترض أننا جلبنا كل ما نحتاجه
        ));
      },
    );
  }


Future<void> fetchAllLocations() async {
    if ((state.locations?.isNotEmpty ?? false) || state.status == AppStatus.loading) {
      return;
    }

    emit(state.copyWith(status: AppStatus.loading, locations: [], currentPage: 1, hasReachedMax: false));

    List<LocationEntity> allLocations = [];
    int currentPage = 1;
    bool hasMorePages = true;

    while (hasMorePages) {
      final result = await getLocationsUseCase(currentPage);

      result.fold(
        (failure) {
          // --- [التعديل الرئيسي هنا] ---
          // بدلاً من إصدار حالة خطأ، فقط أوقف الحلقة.
          // هذا يعني أننا وصلنا إلى نهاية الصفحات (أو حدث خطأ غير متوقع).
          // في كلتا الحالتين، يجب أن نعرض البيانات التي جمعناها حتى الآن.
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

    // --- [تعديل ثانوي] ---
    // الآن، بغض النظر عن سبب توقف الحلقة (نهاية البيانات أو خطأ)،
    // سنقوم بإصدار حالة النجاح مع كل البيانات التي تمكنا من جمعها.
    // هذا يضمن ظهور البيانات في الـ UI.
    emit(state.copyWith(
      status: AppStatus.success,
      locations: allLocations,
      hasReachedMax: true,
    ));
  } /// Resets only the location-related parts of the state.
  void resetLocationsState() {
    emit(state.copyWith(
      locations: [],
      currentPage: 1,
      hasReachedMax: false,
      status: AppStatus.initial,
    ));
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
        emit(state.copyWith(
          status: AppStatus.failure,
          message: failure.message,
        ));
      },
      (newLocations) {
        final bool hasReachedMax = newLocations.isEmpty;
        
        emit(state.copyWith(
          status: AppStatus.success,
          locations: List.of(state.locations!)..addAll(newLocations),
          currentPage: state.currentPage + 1,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  /// Resets the location state for a fresh start.
  void refreshLocations() {
    // لا تقم بالطلب مرة أخرى إذا كانت البيانات محملة بالفعل
    if (state.locations?.isNotEmpty ?? false) return;
    
    emit(state.copyWith(
      locations: [],
      currentPage: 1,
      hasReachedMax: false,
      status: AppStatus.initial,
    ));
    getNextLocationsPage();
  }


  
}
