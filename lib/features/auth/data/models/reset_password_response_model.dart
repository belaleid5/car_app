
import 'package:car_app/features/auth/domain/entities/reset_password_reponse_entity.dart';

class ResetPasswordResponseModel extends ResetPasswordResponseEntity {
  const ResetPasswordResponseModel({
    required super.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      message: json['message'] ?? 'Password reset successfully',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
    };
  }
}