import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:car_app/features/auth/domain/use_cases/save_tokens_params.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});

  @override
  List<Object?> get props => [refreshToken];
}



class SaveTokensUseCase implements BaseUseCase<void, SaveTokensParams> {
  final AuthRepository repository;

  SaveTokensUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveTokensParams params) async {
    return await repository.saveTokens(params.tokens);
  }
}