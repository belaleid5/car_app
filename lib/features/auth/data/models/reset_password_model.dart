import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';

class ResetPasswordModel extends ResetPasswordRequestEntity{
  const ResetPasswordModel({required super.email});


  factory ResetPasswordModel.fromEntity(ResetPasswordRequestEntity entity) {
    return ResetPasswordModel(email: entity.email,);
import 'package:car_app/features/auth/domain/entities/reset_password_entity.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  const ResetPasswordModel({
    required super.resetToken,
    required super.code,
    required super.password,
    required super.confirmPassword,
  });

  factory ResetPasswordModel.fromEntity(ResetPasswordEntity entity) {
    return ResetPasswordModel(
      resetToken: entity.resetToken,
      code: entity.code,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "reset_token": resetToken,      // 🔥 ده اللي هيروح للـ API
      "code": code,                   // 🔥 ده اللي هيروح للـ API  
      "password": password,           // 🔥 ده اللي هيروح للـ API
      "confirm_password": confirmPassword, // 🔥 ده اللي هيروح للـ API
    };
  }
}