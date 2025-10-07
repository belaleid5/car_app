import 'package:equatable/equatable.dart';

class ResponseVerifyCodePhoneEntity extends Equatable {
  final String code;
  final String verifyToken;
  final String message;

 const ResponseVerifyCodePhoneEntity({required this.code, required this.verifyToken, required this.message});
 
  @override
  List<Object?> get props => [
    code,verifyToken,message,
  ];
}
