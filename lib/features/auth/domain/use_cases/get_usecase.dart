import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';


class GetTokensUseCase implements BaseUseCase<AuthTokensEntity?, NoParams> {
  final AuthRepository repository;

  GetTokensUseCase(this.repository);

  @override
  Future<Either<Failure, AuthTokensEntity?>> call(NoParams params) async {
    return await repository.getTokens();
  }
}