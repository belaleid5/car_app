import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/core/services/services_sharedprefrences.dart';

abstract class CacheManager<T> {
  Future<void> cache(String key, T item);
  Future<T?> getCached(String key);
  Future<bool> isCacheValid(String key);
  Future<void> clearCache();
  Future<void> clearExpiredCache();
}

/// Base implementation using SharedPreferencesService
abstract class BaseCacheManager<T> implements CacheManager<T> {
  final SharedPreferencesService _prefsService;
  final Duration _cacheValidDuration;
  final String _cachePrefix;

  BaseCacheManager({
    required SharedPreferencesService prefsService,
    required Duration cacheValidDuration,
    required String cachePrefix,
  })  : _prefsService = prefsService,
        _cacheValidDuration = cacheValidDuration,
        _cachePrefix = cachePrefix;

  @override
  Future<void> cache(String key, T item) async {
    try {
      final cacheKey = '$_cachePrefix$key';
      final serialized = serialize(item);
      await _prefsService.setCacheWithTime(cacheKey, serialized);
      print('💾 Cached item with key: $cacheKey');
    } catch (e) {
      print('❌ Failed to cache item: $e');
      throw CacheException('فشل في حفظ البيانات: $e');
    }
  }

  @override
  Future<T?> getCached(String key) async {
    try {
      final cacheKey = '$_cachePrefix$key';
      final serialized = _prefsService.getCacheIfValid(cacheKey, _cacheValidDuration);
      
      if (serialized == null) return null;
      
      final item = deserialize(serialized);
      print('✅ Retrieved cached item with key: $cacheKey');
      return item;
    } catch (e) {
      print('❌ Failed to get cached item: $e');
      return null;
    }
  }

  @override
  Future<bool> isCacheValid(String key) async {
    final cacheKey = '$_cachePrefix$key';
    return await _prefsService.isCacheValid(cacheKey, _cacheValidDuration);
  }

  @override
  Future<void> clearCache() async {
    try {
      final keys = _prefsService.getKeys();
      final cacheKeys = keys.where((key) => key.startsWith(_cachePrefix)).toList();
      
      for (final key in cacheKeys) {
        await _prefsService.remove(key);
      }
      
      print('🧹 Cleared cache for prefix: $_cachePrefix');
    } catch (e) {
      print('❌ Failed to clear cache: $e');
    }
  }

  @override
  Future<void> clearExpiredCache() async {
    try {
      final keys = _prefsService.getKeys();
      final cacheKeys = keys.where((key) => key.startsWith(_cachePrefix)).toList();
      
      int clearedCount = 0;
      for (final key in cacheKeys) {
        final isValid = await _prefsService.isCacheValid(key, _cacheValidDuration);
        if (!isValid) {
          await _prefsService.remove(key);
          clearedCount++;
        }
      }
      
      print('🧹 Cleared $clearedCount expired cache entries');
    } catch (e) {
      print('❌ Failed to clear expired cache: $e');
    }
  }

  /// Serialize item to string (implemented by subclasses)
  String serialize(T item);

  /// Deserialize string to item (implemented by subclasses)
  T deserialize(String data);
}
