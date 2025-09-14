import 'package:equatable/equatable.dart';

class ResetPasswordRequestEntity extends Equatable{

  final String email;


  
 const ResetPasswordRequestEntity({
   required this.email,
 });

  @override
  List<Object?> get props => [
     email,];
}