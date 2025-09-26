import 'package:car_app/core/error/dio_excaeption.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/data/models/auth_token_model.dart';
import 'package:car_app/features/auth/data/models/confirm_code_phone_modl.dart';
import 'package:car_app/features/auth/data/models/confirm_passowrd_response_model.dart';
import 'package:car_app/features/auth/data/models/forget_password_model.dart';
import 'package:car_app/features/auth/data/models/login_request_model.dart';
import 'package:car_app/features/auth/data/models/login_response_model.dart';
import 'package:car_app/features/auth/data/models/refresh_token_model.dart';
import 'package:car_app/features/auth/data/models/register_response.dart';
import 'package:car_app/features/auth/data/models/request_verify_code_phone_model.dart';
import 'package:car_app/features/auth/data/models/reset_password_model.dart';
import 'package:car_app/features/auth/data/models/reset_password_response_model.dart';
import 'package:car_app/features/auth/data/models/response_verify_code_phone_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponseModel> register(RegisterRequestModel registerRequest);
  Future<AuthTokensModel> refreshToken(String refreshToken);
  Future<LoginResponseModel> login(LoginRequestModel loginRequest);
  Future<MessageResponseModel> resetPassword(ResetPasswordModel resetModel);
  Future<ConfirmPasswordResponseModel> forgetPassword(
    ForgetPasswordModel resetModel,
  );
  Future<ResponseVerifyCodePhoneModel> verifyCodePhone(
    RequestVerifyCodePhoneModel resetModel,
  );
  Future<MessageResponseModel> confirmCodePhone(
    ConfirmCodePhoneModel confirmPhone);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<RegisterResponseModel> register(
    RegisterRequestModel registerRequest,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.registerEndpoint,
        data: registerRequest.toJson(),
        options: Options(
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
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
      // استخدام ErrorHandler بشكل صحيح
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<AuthTokensModel> refreshToken(String refreshToken) async {
    try {
      final refreshRequest = RefreshTokenRequestModel(
        refreshToken: refreshToken,
      );
      final response = await dio.post(
        ApiConstants.refreshTokenEndpoint,
        data: refreshRequest.toJson(),
        options: Options(
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
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
      // استخدام ErrorHandler بشكل صحيح
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
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
        options: Options(
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
        ),
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
      // استخدام ErrorHandler بشكل صحيح
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<MessageResponseModel> resetPassword(
    ResetPasswordModel resetModel,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.resetPasswordEndpoint,
        data: resetModel.toJson(),
        options: Options(
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
        ),
      );

      if (response.statusCode == 200) {
        return MessageResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.data["message"] ?? "Reset Password failed",
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      // استخدام ErrorHandler بشكل صحيح
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<ConfirmPasswordResponseModel> forgetPassword(
    ForgetPasswordModel resetModel,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.forgotPasswordEndpoint,
        data: resetModel.toJson(),
        options: Options(
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
        ),
      );

      if (response.statusCode == 200) {
        return ConfirmPasswordResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.data["message"] ?? "Forgot Password failed",
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      // استخدام ErrorHandler بشكل صحيح
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<ResponseVerifyCodePhoneModel> verifyCodePhone(
    RequestVerifyCodePhoneModel resetModel,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.verifyCodePhoneEndpoint,
        data: resetModel.toJson(),
        options: Options(
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
        ),
      );

      if (response.statusCode == 200) {
        return ResponseVerifyCodePhoneModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.data["message"] ?? "Verify Code PHone failed",
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
  
  @override
  Future<MessageResponseModel> 
  confirmCodePhone(ConfirmCodePhoneModel confirmPhone) async {
    try {
      final response = await dio.post(
        ApiConstants.confirmCodePhoneEndpoint,
        data: confirmPhone.toJson(),
        options: Options(
          headers: {ApiConstants.contentType: ApiConstants.applicationJson},
        ),
      );

      if (response.statusCode == 200) {
        return MessageResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.data["message"] ?? "confirm Code PHone failed",
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      final errorMessage = ErrorHandler.handle(e);
      throw ServerException(errorMessage, e.response?.statusCode ?? 500);
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}
