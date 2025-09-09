import 'package:car_app/core/constants/api_constants.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/data/data_sources/local_datasource.dart';
import 'package:car_app/features/auth/data/models/auth_token_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _localDataSource = GetIt.instance<AuthLocalDataSource>();
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip auth for certain endpoints
    if (_shouldSkipAuth(options.path)) {
      return handler.next(options);
    }

    try {
      final tokens = await _localDataSource.getTokens();
      if (tokens != null) {
        options.headers['Authorization'] = '${ApiConstants.bearer} ${tokens.accessToken}';
      }
    } catch (e) {
      // Continue without token if there's an error getting it
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token refresh on 401 errors
    if (err.response?.statusCode == 401 && !_shouldSkipAuth(err.requestOptions.path)) {
      try {
        final refreshed = await _refreshTokenAndRetry(err);
        if (refreshed != null) {
          return handler.resolve(refreshed);
        }
      } catch (e) {
        // If refresh fails, clear tokens and continue with error
        await _localDataSource.clearTokens();
      }
    }

    handler.next(err);
  }

  Future<Response?> _refreshTokenAndRetry(DioException err) async {
    try {
      final tokens = await _localDataSource.getTokens();
      if (tokens == null) return null;

      // Create a new Dio instance to avoid interceptor loops
      final refreshDio = Dio();
      refreshDio.options.baseUrl = ApiConstants.baseUrl;

      final response = await refreshDio.post(
        ApiConstants.refreshTokenEndpoint,
        data: {'refresh': tokens.refreshToken},
      );

      if (response.statusCode == 200) {
        final newTokensData = response.data['tokens'] ?? response.data;
        final newAccessToken = newTokensData['access'];
        final newRefreshToken = newTokensData['refresh'] ?? tokens.refreshToken;

        // Save new tokens
        await _localDataSource.saveTokens(
          AuthTokensModel(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          ),
        );

        // Retry original request with new token
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = '${ApiConstants.bearer} $newAccessToken';
        
        return await Dio().fetch(retryOptions);
      }
    } catch (e) {
      throw TokenExpiredException('Token refresh failed');
    }

    return null;
  }

  bool _shouldSkipAuth(String path) {
    final skipPaths = [
      ApiConstants.registerEndpoint,
      ApiConstants.loginEndpoint,
      ApiConstants.refreshTokenEndpoint,
      '/forgot-password',
      '/reset-password',
    ];
    
    return skipPaths.any((skipPath) => path.contains(skipPath));
  }
}
