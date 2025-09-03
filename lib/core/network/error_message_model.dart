import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int? statusCode;
  final String message;
  final bool? isSuccess;

  const ErrorMessageModel({
    this.statusCode,
    required this.message,
    this.isSuccess,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      statusCode: json['status_code'] ?? 0,
      message: json['status_message'] ??
          json['message'] ??
          json['error'] ??
          json['detail'] ??
          'An unexpected error occurred',
      isSuccess: json['success'],
    );
  }

  @override
  List<Object?> get props => [statusCode, message, isSuccess];

  @override
  String toString() => message;
}
