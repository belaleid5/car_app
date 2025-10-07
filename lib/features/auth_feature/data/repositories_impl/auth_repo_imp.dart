import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth_feature/data/data_sources/local_datasource.dart';
import 'package:car_app/features/auth_feature/data/data_sources/remote_data_source.dart';
import 'package:car_app/features/auth_feature/data/models/auth_token_model.dart';
import 'package:car_app/features/auth_feature/data/models/confirm_code_phone_modl.dart';
import 'package:car_app/features/auth_feature/data/models/forget_password_model.dart';
import 'package:car_app/features/auth_feature/data/models/login_request_model.dart';
import 'package:car_app/features/auth_feature/data/models/request_verify_code_phone_model.dart';
import 'package:car_app/features/auth_feature/data/models/reset_password_model.dart';
import 'package:car_app/features/auth_feature/data/models/user_model.dart';
import 'package:car_app/features/auth_feature/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/confirm_code_phone_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/confirm_password_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/forget_password_request_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/login_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/login_response_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/request_verify_code_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/reset_password_reponse_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/response_verfiy_code_phone_entity.dart';
import 'package:car_app/features/auth_feature/domain/repositories/auth_repo.dart';
import 'package:car_app/features/auth_feature/presentation/pages/verfiy_phone_screen.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/register_request_entity.dart';
import '../../domain/entities/register_response_entity.dart';
import '../models/register_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RegisterResponseEntity>> register(
    RegisterRequestEntity registerRequest,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final registerRequestModel = RegisterRequestModel.fromEntity(
        registerRequest,
      );
      final result = await remoteDataSource.register(registerRequestModel);

      await localDataSource.saveTokens(result.tokens as AuthTokensModel);
      await localDataSource.saveUser(result.user as UserModel);

      return Right(result);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on ServerException catch (e) {
      if (e.statusCode == 400 || e.statusCode == 422) {
        return Left(ValidationFailure(e.message));
      } else if (e.statusCode == 401) {
        return Left(AuthFailure(e.message));
      }
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthTokensEntity>> refreshToken(
    String refreshToken,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final result = await remoteDataSource.refreshToken(refreshToken);
      return Right(result);
    } on TokenExpiredException catch (e) {
      await localDataSource.clearTokens();
      return Left(TokenExpiredFailure(e.message));
    } on ServerException catch (e) {
      if (e.statusCode == 401) {
        await localDataSource.clearTokens();
        return Left(TokenExpiredFailure(e.message));
      }
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveTokens(AuthTokensEntity tokens) async {
    try {
      final tokensModel = tokens is AuthTokensModel
          ? tokens
          : AuthTokensModel(
              accessToken: tokens.accessToken,
              refreshToken: tokens.refreshToken,
            );

      await localDataSource.saveTokens(tokensModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to save tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthTokensEntity?>> getTokens() async {
    try {
      final result = await localDataSource.getTokens();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to get tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clearTokens() async {
    try {
      await localDataSource.clearTokens();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to clear tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final result = await localDataSource.isLoggedIn();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to check authentication: $e'));
    }
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> login(
    LoginRequestEntity request,
  ) async {
    try {
      final requestModel = LoginRequestModel.fromEntity(request);
      final responseModel = await remoteDataSource.login(requestModel);
      return Right(responseModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConfirmPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    try {
      final requestModel = ForgetPasswordModel.fromEntity(request);
      final responseModel = await remoteDataSource.forgetPassword(requestModel);
      return Right(responseModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageResponseEntity>> resetPassword(
    ResetRequestPasswordEntity request,
  ) async {
    try {
      final requestModel = ResetPasswordModel.fromEntity(request);
      final responseModel = await remoteDataSource.resetPassword(requestModel);
      return Right(responseModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseVerifyCodePhoneEntity>> verifyCodePhone(
    RequestVerifyCodePhoneEntity phoneRequest,
  ) async {
    try {
      final requestModel = RequestVerifyCodePhoneModel.fromEntity(phoneRequest);
      final responseModel = await remoteDataSource.verifyCodePhone(
        requestModel,
      );
      return Right(responseModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageResponseEntity>> 
  confirmCodePhone(ConfirmCodePhoneEntity phoneRequest) async {
    try {
      final requestModel = ConfirmCodePhoneModel.fromEntity(phoneRequest);
      final responseModel = await remoteDataSource.confirmCodePhone(
        requestModel,
      );


      return Right(responseModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


}
