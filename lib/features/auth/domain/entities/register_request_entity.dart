import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String country;

  const RegisterRequestEntity({
    required this.fullName,
    required this.email,
    required this.password,
    required this.country,
  });

  @override
  List<Object?> get props => [fullName, email, password, country];
}