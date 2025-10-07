import 'package:equatable/equatable.dart';

class ConfirmPasswordResponseEntity extends Equatable {
  final String message;
  final String resetToken;
  final String code;

  const ConfirmPasswordResponseEntity({
    required this.message,
    required this.resetToken,
    required this.code,
  });

  @override
  List<Object?> get props => [message, resetToken, code];
}
