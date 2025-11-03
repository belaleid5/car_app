import 'package:car_app/core/error/faliure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// ignore: avoid_types_as_parameter_names
abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}