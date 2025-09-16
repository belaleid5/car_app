import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/confirm_password_entity.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final AppStatus status;
  final AuthTokensEntity? tokens;
  final ConfirmPasswordResponseEntity? confirmPasswordResponse; // أسم أوضح
  final String? message;

  const AuthState({
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
}) {
  return AuthState(
    status: status ?? this.status,
    tokens: tokens ?? this.tokens,
    message: message ?? this.message,
    confirmPasswordResponse: confirmPasswordResponse ?? this.confirmPasswordResponse, // تصحيح هنا
  );
}

  @override
  List<Object?> get props => [confirmPasswordResponse, status, tokens, message];
}
