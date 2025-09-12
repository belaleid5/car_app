import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  final AuthTokensEntity tokens;
  final UserEntity user;
  final String message;

  const LoginResponseEntity( {
    required this.tokens,
    required this.user,
    required this.message,
  });
  

  @override
  List<Object?> get props => [tokens, user, message];


}
 