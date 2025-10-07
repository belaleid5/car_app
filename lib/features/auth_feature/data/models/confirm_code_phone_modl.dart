import 'package:car_app/features/auth_feature/domain/entities/confirm_code_phone_entity.dart';

class ConfirmCodePhoneModel extends ConfirmCodePhoneEntity {
  const ConfirmCodePhoneModel({
    required super.verifyCode,
    required super.verifyToken,
  });

  factory ConfirmCodePhoneModel.fromEntity(ConfirmCodePhoneEntity entity) {
    return ConfirmCodePhoneModel(
      verifyCode: entity.verifyCode,
      verifyToken: entity.verifyToken,
    );
  }

  factory ConfirmCodePhoneModel.formJson(Map<String, dynamic> json) {
    return ConfirmCodePhoneModel(
      verifyCode: json["code"] ?? "",
      verifyToken: json["verify_token"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"code": verifyCode, "verify_token": verifyToken};
  }
}
