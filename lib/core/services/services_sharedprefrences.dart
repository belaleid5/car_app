import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Core service for SharedPreferences operations
/// Used across the entire application
abstract class SharedPreferencesService {
  SharedPreferencesService(SharedPreferences sharedPreferences);

  // Basic operations
  Future<bool> setBool(String key, bool value);
  Future<bool> setString(String key, String value);
  Future<bool> setInt(String key, int value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setStringList(String key, List<String> value);

  bool? getBool(String key);
  String? getString(String key);
  int? getInt(String key);
  double? getDouble(String key);
  List<String>? getStringList(String key);

  Future<bool> remove(String key);
  Future<bool> clear();
  Set<String> getKeys();
  bool containsKey(String key);

  // JSON operations
  Future<bool> setJson(String key, Map<String, dynamic> value);
  Map<String, dynamic>? getJson(String key);

  // Cache operations with timestamps
  Future<bool> setCacheWithTime(String key, String value);
  String? getCacheIfValid(String key, Duration validDuration);
  Future<bool> isCacheValid(String key, Duration validDuration);
}

/// Implementation of SharedPreferencesService
class SharedPreferencesServiceImpl implements SharedPreferencesService {
  final SharedPreferences _prefs;
  
  static const String _timePrefix = 'CACHE_TIME_';

  const SharedPreferencesServiceImpl({
    required SharedPreferences sharedPreferences,
  }) : _prefs = sharedPreferences;

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  @override
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  @override
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  @override
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  @override
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  @override
  Future<bool> clear() async {
    return await _prefs.clear();
  }

  @override
  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  @override
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  @override
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = json.encode(value);
      return await setString(key, jsonString);
    } catch (e) {
      print('❌ Error setting JSON for key $key: $e');
      return false;
    }
  }

  @override
  Map<String, dynamic>? getJson(String key) {
    try {
      final jsonString = getString(key);
      if (jsonString == null) return null;
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('❌ Error getting JSON for key $key: $e');
      return null;
    }
  }

  @override
  Future<bool> setCacheWithTime(String key, String value) async {
    try {
      final success = await setString(key, value);
      if (success) {
        final timeKey = '$_timePrefix$key';
        final timestamp = DateTime.now().toIso8601String();
        await setString(timeKey, timestamp);
      }
      return success;
    } catch (e) {
      print('❌ Error setting cache with time for key $key: $e');
      return false;
    }
  }

  @override
  String? getCacheIfValid(String key, Duration validDuration) {
    try {
      if (isCacheValidSync(key, validDuration)) {
        return getString(key);
      }
      return null;
    } catch (e) {
      print('❌ Error getting valid cache for key $key: $e');
      return null;
    }
  }

  @override
  Future<bool> isCacheValid(String key, Duration validDuration) async {
    return isCacheValidSync(key, validDuration);
  }

  /// Synchronous cache validity check
  bool isCacheValidSync(String key, Duration validDuration) {
    try {
      final timeKey = '$_timePrefix$key';
      final timestampString = getString(timeKey);
      
      if (timestampString == null) return false;
      
      final timestamp = DateTime.parse(timestampString);
      final now = DateTime.now();
      
      return now.difference(timestamp) < validDuration;
    } catch (e) {
      print('❌ Error checking cache validity for key $key: $e');
      return false;
    }
  }
}