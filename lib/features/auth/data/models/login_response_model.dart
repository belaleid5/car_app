import 'package:car_app/features/auth/data/models/auth_token_model.dart';
import 'package:car_app/features/auth/data/models/user_model.dart';
import 'package:car_app/features/auth/domain/entities/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({
    required AuthTokensModel super.tokens,
    required UserModel super.user,
    required super.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      tokens: AuthTokensModel.fromJson(json['tokens']),
      user: UserModel.fromJson(json['user']),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tokens": (tokens as AuthTokensModel).toJson(),
      "user": (user as UserModel).toJson(),
      "message": message,
    };
  }
}

