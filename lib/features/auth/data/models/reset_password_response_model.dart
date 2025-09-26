import 'package:car_app/features/auth/domain/entities/reset_password_reponse_entity.dart';

class MessageResponseModel extends MessageResponseEntity {
  const MessageResponseModel({required super.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      message: json['message'] ?? 'Password reset successfully',
    );
  }

  Map<String, dynamic> toJson() {
    return {"message": message};
  }
}
