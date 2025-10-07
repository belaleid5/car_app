import 'package:equatable/equatable.dart';

class RequestVerifyCodePhoneEntity extends Equatable {
  final String phone;

  const RequestVerifyCodePhoneEntity({required this.phone});
  
  @override
  List<Object?> get props => [
    phone,
  ];
}
