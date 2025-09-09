import '../../domain/entities/register_request_entity.dart';

class RegisterRequestModel extends RegisterRequestEntity {
  const RegisterRequestModel({
    required super.fullName,
    required super.email,
    required super.password,
    required super.country,
  });

  factory RegisterRequestModel.fromEntity(RegisterRequestEntity entity) {
    return RegisterRequestModel(
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      country: entity.country,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'country': country,
    };
  }
}