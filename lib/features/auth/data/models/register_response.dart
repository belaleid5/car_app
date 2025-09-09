// lib/features/auth/data/models/register_response_model.dart
import 'package:car_app/features/auth/data/models/auth_token_model.dart';

import '../../domain/entities/register_response_entity.dart';
import 'user_model.dart';




class RegisterResponseModel extends RegisterResponseEntity {
  const RegisterResponseModel({
    required super.user,
    required super.message,
    required super.tokens,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String,
      tokens: AuthTokensModel.fromJson(json['tokens'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user as UserModel).toJson(),
      'message': message,
      'tokens': (tokens as AuthTokensModel).toJson(),
    };
  }
}