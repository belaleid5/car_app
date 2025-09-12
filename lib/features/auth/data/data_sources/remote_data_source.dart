import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/data/models/auth_token_model.dart';
import 'package:car_app/features/auth/data/models/login_request_model.dart';
import 'package:car_app/features/auth/data/models/login_response_model.dart';
import 'package:car_app/features/auth/data/models/refresh_token_model.dart';
import 'package:car_app/features/auth/data/models/register_response.dart';
import 'package:dio/dio.dart';
import '../models/register_request_model.dart';

import '../../../../core/constants/api_constants.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponseModel> register(RegisterRequestModel registerRequest);
  Future<AuthTokensModel> refreshToken(String refreshToken);
    Future<LoginResponseModel> login(LoginRequestModel loginRequest);

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel registerRequest) async {
    try {
      final response = await dio.post(
        ApiConstants.registerEndpoint,
        data: registerRequest.toJson(),
        options: Options(
          headers: {
            ApiConstants.contentType: ApiConstants.applicationJson,
          },
        ),
      );

      if (response.statusCode == 201) {
        return RegisterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Registration failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException('No internet connection');
      } else if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final message = e.response!.data?['message'] ?? 'Server error occurred';
        throw ServerException(message, statusCode);
      } else {
        throw const ServerException('Unknown server error occurred');
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<AuthTokensModel> refreshToken(String refreshToken) async {
    try {
      final refreshRequest = RefreshTokenRequestModel(refreshToken: refreshToken);
      
      final response = await dio.post(
        ApiConstants.refreshTokenEndpoint,
        data: refreshRequest.toJson(),
        options: Options(
          headers: {
            ApiConstants.contentType: ApiConstants.applicationJson,
          },
        ),
      );

      if (response.statusCode == 200) {
        return AuthTokensModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Token refresh failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const TokenExpiredException('Refresh token expired');
      } else if (e.type == DioExceptionType.connectionTimeout ||
                 e.type == DioExceptionType.receiveTimeout ||
                 e.type == DioExceptionType.sendTimeout) {
        throw const NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException('No internet connection');
      } else if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final message = e.response!.data?['message'] ?? 'Server error occurred';
        throw ServerException(message, statusCode);
      } else {
        throw const ServerException('Unknown server error occurred');
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
  
 @override
  Future<LoginResponseModel> login(LoginRequestModel loginRequest) async {
    try {
      final response = await dio.post(
        ApiConstants.loginEndpoint,
        data: loginRequest.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
         response.data["message"] ?? "Login failed",
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
           e.response?.data["message"] ?? "Login error",
           e.response?.statusCode ?? 500,
        );
      } else {
        throw NetworkException("No internet connection");
      }
    } catch (e) {
      throw ServerException( e.toString(),  500);
    }
  }
}