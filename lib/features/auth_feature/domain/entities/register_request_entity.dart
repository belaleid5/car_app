import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final int locationId;
  final String countryCode;
  final String phoneNumber;
  final bool availableToCreateCar;

  const RegisterRequestEntity( {
    required this.locationId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.phoneNumber,
    required this.availableToCreateCar, 
  });

  @override
  List<Object?> get props => [
    locationId,
    phoneNumber,
    fullName,
    email,
    password,
    countryCode,
  ];
}
