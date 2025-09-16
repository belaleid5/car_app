import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_reponse_entity.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase
    implements BaseUseCase<ResetPasswordResponseEntity, ResetRequestPasswordEntity> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordResponseEntity>> call(
    ResetRequestPasswordEntity params,
  ) async {
    return await repository.resetPassword(params);
  }
}
