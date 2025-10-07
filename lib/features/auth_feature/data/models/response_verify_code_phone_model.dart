import 'package:car_app/features/auth_feature/domain/entities/response_verfiy_code_phone_entity.dart';

class ResponseVerifyCodePhoneModel extends ResponseVerifyCodePhoneEntity {
  const ResponseVerifyCodePhoneModel({
    required super.code,
    required super.verifyToken,
    required super.message,
  });

  factory ResponseVerifyCodePhoneModel.fromEntity(
    ResponseVerifyCodePhoneEntity response,
  ) {
    return ResponseVerifyCodePhoneModel(
      code: response.code,
      verifyToken: response.verifyToken,
      message: response.message,
    );
  }

  factory ResponseVerifyCodePhoneModel.fromJson(Map<String, dynamic> fromJson) {
    return ResponseVerifyCodePhoneModel(
      code:fromJson["code"]?? '', 
      verifyToken: fromJson["verify_token"]??'', 
      message: fromJson["message"]??'');
  }
}
