import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String countryCode;
  final String phoneNumber;

  const RegisterRequestEntity({
    required this.fullName,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.phoneNumber,
  });



  @override
  List<Object?> get props => [
    phoneNumber,
    fullName, email, password, countryCode];
}