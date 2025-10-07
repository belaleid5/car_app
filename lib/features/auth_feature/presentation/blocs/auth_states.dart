import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/auth_feature/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/confirm_code_phone_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/confirm_password_entity.dart';
import 'package:car_app/core/shared/location_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/response_verfiy_code_phone_entity.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final AppStatus status;
  final AuthTokensEntity? tokens;
  final ConfirmPasswordResponseEntity? confirmPasswordResponse;
  final ResponseVerifyCodePhoneEntity? responseVerifyCodePhone;
  final  ConfirmCodePhoneEntity ? confirmCodePhoneEntity;

  final String? message;

  final List<LocationEntity>? locations;
  final int currentPage;
  final bool hasReachedMax;

  final String? currentSearchQuery;

  const AuthState( {
    this.status = AppStatus.initial,
    this.tokens,
    this.message,
    this.confirmCodePhoneEntity,
    this.confirmPasswordResponse,
    this.responseVerifyCodePhone,

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
    ResponseVerifyCodePhoneEntity? responseVerifyCodePhone,
    ConfirmCodePhoneEntity ? confirmCodePhoneEntity,

    String? message,

    List<LocationEntity>? locations,
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
      responseVerifyCodePhone:
          responseVerifyCodePhone ?? this.responseVerifyCodePhone,
confirmCodePhoneEntity: confirmCodePhoneEntity ?? this.confirmCodePhoneEntity,
      locations: locations ?? this.locations,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,

      currentSearchQuery: currentSearchQuery ?? this.currentSearchQuery,
    );
  }

  @override
  List<Object?> get props => [
    status,
    tokens,
    message,
    confirmPasswordResponse,
    locations,
    currentPage,
    hasReachedMax,
    currentSearchQuery,
    confirmCodePhoneEntity,
  ];
}
