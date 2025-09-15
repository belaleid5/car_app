import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  final String resetToken;
  final String code;
  final String password;
  final String confirmPassword;

  const ResetPasswordEntity({
    required this.resetToken,
    required this.code,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [resetToken, code, password, confirmPassword];
}
