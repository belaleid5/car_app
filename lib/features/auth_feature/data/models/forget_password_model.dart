import 'package:car_app/features/auth_feature/domain/entities/forget_password_request_entity.dart';

class ForgetPasswordModel extends ForgetPasswordRequestEntity {
  const ForgetPasswordModel({required super.email});

  factory ForgetPasswordModel.fromEntity(ForgetPasswordRequestEntity entity) {
    return ForgetPasswordModel(email: entity.email);
  }

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
