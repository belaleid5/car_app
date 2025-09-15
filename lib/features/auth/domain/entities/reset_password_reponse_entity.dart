import 'package:equatable/equatable.dart';

class ResetPasswordResponseEntity extends Equatable {
  final String message;

 const ResetPasswordResponseEntity({required this.message});
 
  @override
  List<Object?> get props => [
    message,
  ];
}
