import 'package:car_app/core/enums/app_states.dart';
import 'package:equatable/equatable.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';


class AuthState extends Equatable {
  final AppStatus status;
  final AuthTokensEntity? tokens;
  final String? message;

  const AuthState({
    this.status = AppStatus.initial,
    this.tokens,
    this.message,
  });

  AuthState copyWith({
    AppStatus? status,
    AuthTokensEntity? tokens,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      tokens: tokens ?? this.tokens,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, tokens, message];
}
