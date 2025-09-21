import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/forget_password_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:car_app/features/auth/domain/entities/location_page_entity.dart';
import 'package:car_app/features/auth/domain/entities/login_entity.dart';
import 'package:car_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth/domain/params/get-location_by_id_params.dart';
import 'package:car_app/features/auth/domain/params/get_location_params.dart';
import 'package:car_app/features/auth/domain/params/search_location_params.dart';
import 'package:car_app/features/auth/domain/use_cases/check_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_location_by_id-usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_location_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/get_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/refresh_tokens_params.dart';
import 'package:car_app/features/auth/domain/use_cases/register_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:car_app/features/auth/domain/use_cases/save_tokens_params.dart';
import 'package:car_app/features/auth/domain/use_cases/search_location_usecase.dart';
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
  final GetLocationsUseCase getLocationsUseCase;
  final GetLocationByIdUseCase getLocationByIdUseCase;
  final SearchLocationsUseCase searchLocationsUseCase;

  AuthCubit({
    required this.getLocationsUseCase,
    required this.getLocationByIdUseCase,
    required this.searchLocationsUseCase,
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
          confirmPasswordResponse:
              response, // أو resetPasswordResponse حسب اسم الـ field في AuthState
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

  Future<void> getLocations({int page = 1, bool isLoadMore = false}) async {
    // Don't emit loading if it's load more
    if (!isLoadMore) {
      emit(state.copyWith(status: AppStatus.loading));
    }

    final result = await getLocationsUseCase(GetLocationsParams(page: page));

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (locationPage) => _handleGetLocationsSuccess(locationPage, isLoadMore),
    );
  }

  /// Get location by ID
  Future<void> getLocationById(int id) async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await getLocationByIdUseCase(GetLocationByIdParams(id: id));

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (location) => emit(
        state.copyWith(
          status: AppStatus.success,
          selectedLocation: location,
          message: "تم جلب الموقع بنجاح",
        ),
      ),
    );
  }

  /// Search locations
  Future<void> searchLocations({
    required String query,
    int page = 1,
    bool isLoadMore = false,
  }) async {
    // Don't emit loading if it's load more
    if (!isLoadMore) {
      emit(
        state.copyWith(status: AppStatus.loading, currentSearchQuery: query),
      );
    }

    final result = await searchLocationsUseCase(
      SearchLocationsParams(query: query, page: page),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: AppStatus.failure, message: failure.message),
      ),
      (locationPage) => _handleSearchSuccess(locationPage, query, isLoadMore),
    );
  }

  /// Load more locations (pagination)
  Future<void> loadMoreLocations() async {
    if (state.hasReachedMax! || state.status == AppStatus.loading) return;

    final nextPage = state.currentPage! + 1;

    if (state.currentSearchQuery != null &&
        state.currentSearchQuery!.isNotEmpty) {
      await searchLocations(
        query: state.currentSearchQuery!,
        page: nextPage,
        isLoadMore: true,
      );
    } else {
      await getLocations(page: nextPage, isLoadMore: true);
    }
  }

  /// Refresh locations (pull to refresh)
  Future<void> refreshLocations() async {
    // Reset pagination
    emit(state.copyWith(currentPage: 1, hasReachedMax: false));

    if (state.currentSearchQuery != null &&
        state.currentSearchQuery!.isNotEmpty) {
      await searchLocations(query: state.currentSearchQuery!, page: 1);
    } else {
      await getLocations(page: 1);
    }
  }

  /// Clear search results and go back to normal locations
  void clearSearch() {
    emit(
      state.copyWith(
        searchResults: null,
        currentSearchQuery: null,
        currentPage: 1,
        hasReachedMax: false,
        status: AppStatus.initial,
      ),
    );
    // Load first page of normal locations
    getLocations(page: 1);
  }

  /// Select a location
  void selectLocation(LocationEntity location) {
    emit(state.copyWith(selectedLocation: location, status: AppStatus.success));
  }

  /// Clear selected location
  void clearSelectedLocation() {
    emit(
      state.copyWith(
        selectedLocation: null,
        status: state.locations != null ? AppStatus.success : AppStatus.initial,
      ),
    );
  }

  /// Reset state to initial
  void resetState() {
    emit(const AuthState());
  }

  void _handleGetLocationsSuccess(
    LocationPageEntity locationPage,
    bool isLoadMore,
  ) {
    List<LocationEntity> allLocations = [];

    if (isLoadMore && state.locations != null) {
      // Append new locations to existing ones
      allLocations = [...state.locations!.locations, ...locationPage.locations];
    } else {
      // Replace with new locations
      allLocations = locationPage.locations;
    }

    // Create updated location page with combined locations
    final updatedLocationPage = LocationPageEntity(
      locations: allLocations,
      pagination: locationPage.pagination,
    );

    // Check if reached max (no more pages)
    final hasReachedMax =
        locationPage.pagination.currentPage >= locationPage.pagination.lastPage;

    emit(
      state.copyWith(
        status: allLocations.isEmpty ? AppStatus.empty : AppStatus.success,
        locationPage: updatedLocationPage,
        currentPage: locationPage.pagination.currentPage,
        hasReachedMax: hasReachedMax,
        message: isLoadMore
            ? "تم تحميل المزيد من المواقع"
            : "تم جلب المواقع بنجاح",
      ),
    );
  }

  /// Handle successful search
  void _handleSearchSuccess(
    LocationPageEntity locationPage,
    String query,
    bool isLoadMore,
  ) {
    List<LocationEntity> allSearchResults = [];

    if (isLoadMore && state.searchResults != null) {
      // Append new search results to existing ones
      allSearchResults = [...state.searchResults!, ...locationPage.locations];
    } else {
      // Replace with new search results
      allSearchResults = locationPage.locations;
    }

    // Check if reached max for search results
    final hasReachedMax =
        locationPage.pagination.currentPage >= locationPage.pagination.lastPage;

    emit(
      state.copyWith(
        status: allSearchResults.isEmpty ? AppStatus.empty : AppStatus.success,
        searchResults: allSearchResults,
        currentSearchQuery: query,
        currentPage: locationPage.pagination.currentPage,
        hasReachedMax: hasReachedMax,
        message: isLoadMore
            ? "تم تحميل المزيد من نتائج البحث"
            : allSearchResults.isEmpty
            ? "لا توجد نتائج للبحث"
            : "تم العثور على ${allSearchResults.length} نتيجة",
      ),
    );
  }
}
