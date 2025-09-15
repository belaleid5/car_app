import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/confirm_password_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_reponse_entity.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase
    implements
        BaseUseCase<ConfirmPasswordResponseEntity, ResetPasswordRequestEntity> {
    implements BaseUseCase<ResetPasswordResponseEntity, ResetPasswordEntity> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, ConfirmPasswordResponseEntity>> call(
    ResetPasswordRequestEntity params,
  ) async {
    final result = await repository.resetPassword(params);

    return result;
  }
}
  Future<Either<Failure, ResetPasswordResponseEntity>> call(
    ResetPasswordEntity params,
  ) async {
    return await repository.resetPassword(params);
  }
}
