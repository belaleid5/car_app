import 'package:car_app/features/auth_feature/domain/entities/request_verify_code_entity.dart';

class RequestVerifyCodePhoneModel extends RequestVerifyCodePhoneEntity {
  const RequestVerifyCodePhoneModel({required super.phone});




  factory RequestVerifyCodePhoneModel.fromEntity(
    RequestVerifyCodePhoneEntity request,
  ) {
    return RequestVerifyCodePhoneModel(phone:request.phone);
  }




  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      
    };
  }
}


