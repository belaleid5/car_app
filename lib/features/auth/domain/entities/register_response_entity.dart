import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class RegisterResponseEntity extends Equatable {
  final UserEntity user;
  final String message;
  final AuthTokensEntity tokens;

  const RegisterResponseEntity({
    required this.user,
    required this.message,
    required this.tokens,
  });

  @override
  List<Object?> get props => [user, message, tokens];
}