import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth_feature/domain/entities/reset_password_reponse_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth_feature/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase
    implements BaseUseCase<MessageResponseEntity, ResetRequestPasswordEntity> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, MessageResponseEntity>> call(
    ResetRequestPasswordEntity params,
  ) async {
    return await repository.resetPassword(params);
  }
}
