import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/data/cache/location_manger_cache.dart';
import 'package:car_app/features/auth/data/models/location-response-model.dart';
import '../models/location_model.dart';

/// Contract for local data source operations
abstract class LocationLocalDataSource {
  /// Cache locations response for specific page
  Future<void> cacheLocationResponse(LocationResponseModel response, int page);
  
  /// Get cached locations response for specific page
  Future<LocationResponseModel> getCachedLocationResponse(int page);
  
  /// Cache single location
  Future<void> cacheLocation(LocationModel location);
  
  /// Get cached location by ID
  Future<LocationModel> getCachedLocation(int id);
  
  /// Cache search results
  Future<void> cacheSearchResults(String query, int page, LocationResponseModel response);
  
  /// Get cached search results
  Future<LocationResponseModel> getCachedSearchResults(String query, int page);
  
  /// Check if cache is valid
  Future<bool> isCacheValid(String cacheKey);
  
  /// Clear all cache
  Future<void> clearAllCache();
}



class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final LocationCacheManager _locationCacheManager;
  final SingleLocationCacheManager _singleLocationCacheManager;
  final SearchCacheManager _searchCacheManager;

  const LocationLocalDataSourceImpl({
    required LocationCacheManager locationCacheManager,
    required SingleLocationCacheManager singleLocationCacheManager,
    required SearchCacheManager searchCacheManager,
  })  : _locationCacheManager = locationCacheManager,
        _singleLocationCacheManager = singleLocationCacheManager,
        _searchCacheManager = searchCacheManager;

  @override
  Future<void> cacheLocationResponse(LocationResponseModel response, int page) async {
    await _locationCacheManager.cache(page.toString(), response);
  }

  @override
  Future<LocationResponseModel> getCachedLocationResponse(int page) async {
    final cached = await _locationCacheManager.getCached(page.toString());
    if (cached == null) {
      throw const CacheException('لا توجد بيانات محفوظة');
    }
    return cached;
  }

  @override
  Future<void> cacheLocation(LocationModel location) async {
    await _singleLocationCacheManager.cache(location.id.toString(), location);
  }

  @override
  Future<LocationModel> getCachedLocation(int id) async {
    final cached = await _singleLocationCacheManager.getCached(id.toString());
    if (cached == null) {
      throw const CacheException('لا يوجد موقع محفوظ');
    }
    return cached;
  }

  @override
  Future<void> cacheSearchResults(String query, int page, LocationResponseModel response) async {
    final key = '${query.hashCode.abs()}_$page';
    await _searchCacheManager.cache(key, response);
  }

  @override
  Future<LocationResponseModel> getCachedSearchResults(String query, int page) async {
    final key = '${query.hashCode.abs()}_$page';
    final cached = await _searchCacheManager.getCached(key);
    if (cached == null) {
      throw const CacheException('لا توجد نتائج بحث محفوظة');
    }
    return cached;
  }

  @override
  Future<bool> isCacheValid(String cacheKey) async {
    return await _locationCacheManager.isCacheValid(cacheKey);
  }

  @override
  Future<void> clearAllCache() async {
    await _locationCacheManager.clearCache();
    await _singleLocationCacheManager.clearCache();
    await _searchCacheManager.clearCache();
  }
}
