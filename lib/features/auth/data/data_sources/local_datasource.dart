import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:car_app/features/auth/data/models/auth_token_model.dart';
import 'package:car_app/features/auth/data/models/user_model.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens(AuthTokensModel tokens);
  Future<AuthTokensModel?> getTokens();
  Future<void> clearTokens();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<void> clearAllAuthData();
  Future<bool> isLoggedIn();
  Future<void> saveLoginState(bool isLoggedIn);
  Future<bool> isFirstTime();
  Future<void> setFirstTime(bool isFirstTime);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _prefs;

  // Secure keys for sensitive data (tokens, user data)
  static const String _accessTokenKey = 'secure_access_token';
  static const String _refreshTokenKey = 'secure_refresh_token';
  static const String _userDataKey = 'secure_user_data';
  static const String _encryptionKey = 'secure_encryption_key';
  
  // Non-sensitive keys for SharedPreferences (app state)
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _isFirstTimeKey = 'is_first_time';

  // Secure storage configuration
  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
    sharedPreferencesName: 'secure_auth_prefs',
    preferencesKeyPrefix: 'secure_',
  );

  static const IOSOptions _iosOptions = IOSOptions(
    groupId: 'group.com.yourcompany.carapp.auth',
    accountName: 'CarAppAuthTokens',
    synchronizable: true,
  );

  static const LinuxOptions _linuxOptions = LinuxOptions();
  static const WindowsOptions _windowsOptions = WindowsOptions();
  static const WebOptions _webOptions = WebOptions();
  static const MacOsOptions _macOptions = MacOsOptions();

  AuthLocalDataSourceImpl(this._prefs)
      : _secureStorage = const FlutterSecureStorage(
          aOptions: _androidOptions,
          iOptions: _iosOptions,
          lOptions: _linuxOptions,
          wOptions: _windowsOptions,
          webOptions: _webOptions,
          mOptions: _macOptions,
        );

  @override
  Future<void> saveTokens(AuthTokensModel tokens) async {
    try {
      // Save tokens in secure storage with encryption
      await _secureStorage.write(
        key: _accessTokenKey, 
        value: tokens.accessToken,
      );
      await _secureStorage.write(
        key: _refreshTokenKey, 
        value: tokens.refreshToken,
      );
      
      // Save login state in regular preferences
      await saveLoginState(true);
    } catch (e) {
      throw CacheException('Failed to save tokens securely: ${e.toString()}');
    }
  }

  @override
  Future<AuthTokensModel?> getTokens() async {
    try {
      final accessToken = await _secureStorage.read(key: _accessTokenKey);
      final refreshToken = await _secureStorage.read(key: _refreshTokenKey);

      if (accessToken != null && refreshToken != null) {
        return AuthTokensModel(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get tokens securely: ${e.toString()}');
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
    } catch (e) {
      throw CacheException('Failed to clear tokens securely: ${e.toString()}');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      // Encrypt and save user data in secure storage
      await _secureStorage.write(key: _userDataKey, value: userJson);
    } catch (e) {
      throw CacheException('Failed to save user data securely: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userJson = await _secureStorage.read(key: _userDataKey);
      if (userJson != null) {
        final userMap = json.decode(userJson) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get user data securely: ${e.toString()}');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _secureStorage.delete(key: _userDataKey);
    } catch (e) {
      throw CacheException('Failed to clear user data securely: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAllAuthData() async {
    try {
      // Clear all secure data
      await clearTokens();
      await clearUser();
      
      // Clear non-sensitive app state
      await saveLoginState(false);
      
      // Optional: Clear ALL secure storage data
      // await _secureStorage.deleteAll();
    } catch (e) {
      throw CacheException('Failed to clear all auth data: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      // Check both login state and secure token existence
      final loginState = _prefs.getBool(_isLoggedInKey) ?? false;
      final tokens = await getTokens();
      
      // User is logged in if both conditions are true
      return loginState && tokens != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> saveLoginState(bool isLoggedIn) async {
    try {
      await _prefs.setBool(_isLoggedInKey, isLoggedIn);
    } catch (e) {
      throw CacheException('Failed to save login state: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFirstTime() async {
    try {
      return _prefs.getBool(_isFirstTimeKey) ?? true;
    } catch (e) {
      return true;
    }
  }

  @override
  Future<void> setFirstTime(bool isFirstTime) async {
    try {
      await _prefs.setBool(_isFirstTimeKey, isFirstTime);
    } catch (e) {
      throw CacheException('Failed to set first time: ${e.toString()}');
    }
  }

  // Secure helper methods

  /// Get access token only from secure storage
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: _accessTokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Get refresh token only from secure storage
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _refreshTokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Check if access token exists in secure storage
  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Check if refresh token exists in secure storage
  Future<bool> hasRefreshToken() async {
    final token = await getRefreshToken();
    return token != null && token.isNotEmpty;
  }

  /// Update only access token in secure storage (useful after token refresh)
  Future<void> updateAccessToken(String accessToken) async {
    try {
      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    } catch (e) {
      throw CacheException('Failed to update access token securely: ${e.toString()}');
    }
  }

  /// Get user ID from secure user data
  Future<int?> getUserId() async {
    try {
      final user = await getUser();
      return user?.id;
    } catch (e) {
      return null;
    }
  }

  /// Get user email from secure user data
  Future<String?> getUserEmail() async {
    try {
      final user = await getUser();
      return user?.email;
    } catch (e) {
      return null;
    }
  }

  // Security utilities

  /// Check if device supports biometric authentication
  Future<bool> supportsBiometrics() async {
    try {
      return await _secureStorage.containsKey(key: _encryptionKey);
    } catch (e) {
      return false;
    }
  }

  /// Migrate data from SharedPreferences to SecureStorage (for app updates)
  Future<void> migrateFromSharedPreferences() async {
    try {
      // Check if old tokens exist in SharedPreferences
      final oldAccessToken = _prefs.getString('access_token');
      final oldRefreshToken = _prefs.getString('refresh_token');
      final oldUserData = _prefs.getString('user_data');

      if (oldAccessToken != null && oldRefreshToken != null) {
        // Move tokens to secure storage
        final tokens = AuthTokensModel(
          accessToken: oldAccessToken,
          refreshToken: oldRefreshToken,
        );
        await saveTokens(tokens);

        // Move user data if exists
        if (oldUserData != null) {
          await _secureStorage.write(key: _userDataKey, value: oldUserData);
        }

        // Clean up old data
        await _prefs.remove('access_token');
        await _prefs.remove('refresh_token');
        await _prefs.remove('user_data');
      }
    } catch (e) {
      // Migration failed, continue normally
    }
  }

  /// Clear all secure storage (nuclear option for logout/reset)
  Future<void> clearAllSecureData() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      throw CacheException('Failed to clear all secure data: ${e.toString()}');
    }
  }

  /// Get all secure storage keys (for debugging - remove in production)
  Future<Map<String, String>> getAllSecureData() async {
    try {
      return await _secureStorage.readAll();
    } catch (e) {
      return {};
    }
  }
}