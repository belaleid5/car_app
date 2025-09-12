// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/domain/entities/auth_token_entity.dart';
import 'package:car_app/features/auth/domain/entities/login_entity.dart';
import 'package:car_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../entities/register_request_entity.dart';
import '../entities/register_response_entity.dart';


abstract class AuthRepository {
  /// Register new user
  Future<Either<Failure, RegisterResponseEntity>> register(
    RegisterRequestEntity registerRequest,
  );

 Future<Either<Failure, LoginResponseEntity>> login(LoginRequestEntity loginRequest);


  /// Refresh access token using refresh token
  Future<Either<Failure, AuthTokensEntity>> refreshToken(String refreshToken);

  /// Save tokens locally
  Future<Either<Failure, void>> saveTokens(AuthTokensEntity tokens);

  /// Get saved tokens
  Future<Either<Failure, AuthTokensEntity?>> getTokens();

  /// Clear saved tokens (logout)
  Future<Either<Failure, void>> clearTokens();

  /// Check if user is authenticated (has valid tokens)
  Future<Either<Failure, bool>> isAuthenticated();
}