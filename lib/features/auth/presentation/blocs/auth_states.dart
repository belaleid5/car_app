import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/confirm_password_entity.dart';
import 'package:car_app/features/auth/domain/entities/location_entity.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final AppStatus status;
  final AuthTokensEntity? tokens;
  final ConfirmPasswordResponseEntity? confirmPasswordResponse;
  final String? message;

  final List<LocationEntity>? locations; // قائمة المواقع
  final int currentPage;
  final bool hasReachedMax;
  // -----------------------------------------

  final String? currentSearchQuery;

  const AuthState({
    this.status = AppStatus.initial,
    this.tokens,
    this.message,
    this.confirmPasswordResponse,
    
    // --- القيم الافتراضية لمتغيرات المواقع ---
    this.locations = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
    // -----------------------------------------

    this.currentSearchQuery,
  });

  AuthState copyWith({
    AppStatus? status,
    AuthTokensEntity? tokens,
    ConfirmPasswordResponseEntity? confirmPasswordResponse,
    String? message,
  
    // --- متغيرات copyWith للمواقع ---
    List<LocationEntity>? locations,
    int? currentPage,
    bool? hasReachedMax,
    // ---------------------------------

    String? currentSearchQuery,
  }) {
    return AuthState(
      status: status ?? this.status,
      tokens: tokens ?? this.tokens,
      message: message ?? this.message,
      confirmPasswordResponse: confirmPasswordResponse ?? this.confirmPasswordResponse,
      
      // --- تحديث متغيرات المواقع ---
      locations: locations ?? this.locations,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      // -----------------------------

      currentSearchQuery: currentSearchQuery ?? this.currentSearchQuery,
    );
  }

  @override
  List<Object?> get props => [
    status,
    tokens,
    message,
    confirmPasswordResponse,

    // --- إضافة متغيرات المواقع إلى props ---
    locations,
    currentPage,
    hasReachedMax,
    // ------------------------------------

    currentSearchQuery,
  ];
}
