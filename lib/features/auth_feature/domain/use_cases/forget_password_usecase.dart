import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth_feature/domain/entities/confirm_password_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/forget_password_request_entity.dart';
import 'package:car_app/features/auth_feature/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUseCase
    implements
        BaseUseCase<
          ConfirmPasswordResponseEntity,
          ForgetPasswordRequestEntity
        > {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, ConfirmPasswordResponseEntity>> call(
    ForgetPasswordRequestEntity params,
  ) async {
    final result = await repository.forgetPassword(params);

    return result;
  }
}
