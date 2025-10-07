import 'package:equatable/equatable.dart';

class MessageResponseEntity extends Equatable {
  final String message;

  const MessageResponseEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
