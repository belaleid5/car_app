import '../../domain/entities/register_request_entity.dart';

class RegisterRequestModel extends RegisterRequestEntity {
  const RegisterRequestModel({
    required super.fullName,
    required super.email,
    required super.password,
    required super.phoneNumber,
    required super.countryCode,
       required super.locationId,
    
  });

  factory RegisterRequestModel.fromEntity(RegisterRequestEntity entity) {
    return RegisterRequestModel(
      locationId: entity.locationId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      countryCode: entity.countryCode,
      phoneNumber: entity.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'country_id': countryCode,
      'phone': phoneNumber,
      "location_id":locationId,
    };
  }
}
