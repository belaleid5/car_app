import 'package:equatable/equatable.dart';

class ConfirmCodePhoneEntity extends Equatable {
  final String verifyCode;
  final String verifyToken;

 const ConfirmCodePhoneEntity({required this.verifyCode, required this.verifyToken});
 
  @override
  List<Object?> get props => [
    verifyCode,
    verifyToken,
  ];
}
