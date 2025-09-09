import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:car_app/features/auth/domain/use_cases/refresh_tokens_params.dart';
import 'package:dartz/dartz.dart';


class RefreshTokenUseCase implements BaseUseCase<AuthTokensEntity, RefreshTokenParams> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Either<Failure, AuthTokensEntity>> call(RefreshTokenParams params) async {
    final result = await repository.refreshToken(params.refreshToken);
    
    return result.fold(
      (failure) => Left(failure),
      (tokens) async {
        // Save new tokens after successful refresh
        final saveResult = await repository.saveTokens(tokens);
        return saveResult.fold(
          (failure) => Left(failure),
          (_) => Right(tokens),
        );
      },
    );
  }
}