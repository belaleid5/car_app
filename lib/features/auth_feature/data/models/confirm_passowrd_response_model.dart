import 'package:car_app/features/auth_feature/domain/entities/confirm_password_entity.dart';

class ConfirmPasswordResponseModel extends ConfirmPasswordResponseEntity {
  const ConfirmPasswordResponseModel({
     required super.message,
     required super.resetToken,
    required super.code,
    });

  factory ConfirmPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ConfirmPasswordResponseModel(
      message: json['message'] ?? '',
      resetToken: json['reset_token'] ?? '', // لاحظ الـ underscore
      code: json['code'] ?? '',
    );
  }

  factory ConfirmPasswordResponseModel.fromEntity(ConfirmPasswordResponseEntity entity) {
    return ConfirmPasswordResponseModel(
      message: entity.message, 
      resetToken: entity.resetToken, 
      code: entity.code);
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "code": code,
      "reset_token": resetToken, 
    };
  }
}