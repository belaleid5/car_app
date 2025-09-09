// lib/features/auth/domain/usecases/save_tokens_usecase.dart
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/usecases/base_use_case.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


class SaveTokensParams extends Equatable {
  final AuthTokensEntity tokens;

  const SaveTokensParams({required this.tokens});

  @override
  List<Object?> get props => [tokens];
}

class SaveTokensUseCase implements BaseUseCase<void, SaveTokensParams> {
  final AuthRepository repository;

  SaveTokensUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveTokensParams params) async {
    return await repository.saveTokens(params.tokens);
  }
}