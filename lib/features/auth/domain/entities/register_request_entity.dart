import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final int locationId;
  final String countryCode;
  final String phoneNumber;

  const RegisterRequestEntity( {
    required this.locationId, 
    required this.fullName,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.phoneNumber,
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
