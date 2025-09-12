import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/register_request_entity.dart';
import '../entities/register_response_entity.dart';

class RegisterUseCase implements BaseUseCase<RegisterResponseEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, RegisterResponseEntity>> call(RegisterParams params) async {
    return await repository.register(params.registerRequest);
  }
}

class RegisterParams extends Equatable {
  final RegisterRequestEntity registerRequest;

  const RegisterParams({required this.registerRequest});

  @override
  List<Object?> get props => [registerRequest];
}