import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/confirm_code_phone_entity.dart';
import 'package:car_app/features/auth/domain/entities/reset_password_reponse_entity.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class RequestConfirmCodePhoneUseCase
    extends BaseUseCase<MessageResponseEntity, ConfirmCodePhoneEntity> {
  final AuthRepository authRepo;

  RequestConfirmCodePhoneUseCase({required this.authRepo});

  @override
  Future<Either<Failure, MessageResponseEntity>> call(
    ConfirmCodePhoneEntity phoneRequest,
  ) async {
    return await authRepo.confirmCodePhone(phoneRequest);
  }
}
