import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth_feature/domain/entities/request_verify_code_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/response_verfiy_code_phone_entity.dart';
import 'package:car_app/features/auth_feature/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class RequestCodeVerifyPhoneUseCase
    extends
        BaseUseCase<
          ResponseVerifyCodePhoneEntity,
          RequestVerifyCodePhoneEntity
        > {
  final AuthRepository authRepository;

  RequestCodeVerifyPhoneUseCase({required this.authRepository});

  @override
  Future<Either<Failure, ResponseVerifyCodePhoneEntity>> call(
    RequestVerifyCodePhoneEntity phoneRequest,
  ) async {
    return await authRepository.verifyCodePhone(phoneRequest);
  }
}
