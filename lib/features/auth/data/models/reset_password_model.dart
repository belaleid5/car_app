import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';

class ResetPasswordModel extends ResetRequestPasswordEntity {
  const ResetPasswordModel({
    required super.resetToken,
    required super.code,
    required super.password,
    required super.confirmPassword,
  });

  factory ResetPasswordModel.fromEntity(ResetRequestPasswordEntity entity) {
    return ResetPasswordModel(
      resetToken: entity.resetToken,
      code: entity.code,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reset_token": resetToken, // 🔥 ده اللي هيروح للـ API
      "code": code, // 🔥 ده اللي هيروح للـ API
      "password": password, // 🔥 ده اللي هيروح للـ API
      "confirm_password": confirmPassword, // 🔥 ده اللي هيروح للـ API
    };
  }
}
