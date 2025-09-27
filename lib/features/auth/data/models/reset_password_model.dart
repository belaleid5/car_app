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
      "reset_token": resetToken.trim(),
      "code": code.trim(),
      "password": password.trim(),
      "confirm_password": confirmPassword.trim(),
    };
  }

  bool get isValid {
    return resetToken.trim().isNotEmpty &&
           code.trim().isNotEmpty &&
           password.trim().isNotEmpty &&
           confirmPassword.trim().isNotEmpty &&
           password.trim() == confirmPassword.trim();
  }

  @override
  String toString() {
    return 'ResetPasswordModel(resetToken: ${resetToken.isNotEmpty ? "***${resetToken.substring(resetToken.length - 4)}" : "empty"}, '
           'code: $code, password: *****, confirmPassword: *****)';
  }
}