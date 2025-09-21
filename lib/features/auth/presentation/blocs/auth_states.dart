import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/confirm_password_entity.dart';
import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:car_app/features/auth/domain/entities/location_page_entity.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final AppStatus status;
  final AuthTokensEntity? tokens;
  final ConfirmPasswordResponseEntity? confirmPasswordResponse; // أسم أوضح
  final String? message;
  final LocationPageEntity? locations;
  final LocationEntity? selectedLocation;
  final List<LocationEntity>? searchResults;
  final int? currentPage;
  final bool? hasReachedMax;
  final String? currentSearchQuery;

  const AuthState({
    this.locations,
    this.selectedLocation,
    this.searchResults,
    this.currentPage,
    this.hasReachedMax,
    this.currentSearchQuery,
    this.confirmPasswordResponse,
    this.status = AppStatus.initial,
    this.tokens,
    this.message,
  });

  AuthState copyWith({
    AppStatus? status,
    AuthTokensEntity? tokens,
    ConfirmPasswordResponseEntity? confirmPasswordResponse,
    String? message,
    LocationPageEntity? locationPage,
    LocationEntity? selectedLocation,
    List<LocationEntity>? searchResults,
    int? currentPage,
    bool? hasReachedMax,
    String? currentSearchQuery,
  }) {
    return AuthState(
      status: status ?? this.status,
      tokens: tokens ?? this.tokens,
      message: message ?? this.message,
      confirmPasswordResponse:
          confirmPasswordResponse ?? this.confirmPasswordResponse,
      currentPage: currentPage,
      hasReachedMax: hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    locations,
    selectedLocation,
    searchResults,
    message,
    currentPage,
    hasReachedMax,
    currentSearchQuery,

    confirmPasswordResponse,
    status,
    tokens,
    message,
  ];
}
