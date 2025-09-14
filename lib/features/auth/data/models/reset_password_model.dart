import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';

class ResetPasswordModel extends ResetPasswordRequestEntity{
  const ResetPasswordModel({required super.email});


  factory ResetPasswordModel.fromEntity(ResetPasswordRequestEntity entity) {
    return ResetPasswordModel(email: entity.email,);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}