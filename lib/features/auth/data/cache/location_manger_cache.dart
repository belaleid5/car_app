import 'dart:convert';
import 'package:car_app/core/cache/location_cache_manger.dart';
import 'package:car_app/features/auth/data/models/location-response-model.dart';

import '../models/location_model.dart';

/// Cache manager specifically for locations
class LocationCacheManager extends BaseCacheManager<LocationResponseModel> {
  LocationCacheManager({
    required super.prefsService,
  }) : super(
          cacheValidDuration: const Duration(hours: 2),
          cachePrefix: 'LOCATION_PAGE_',
        );

  @override
  String serialize(LocationResponseModel item) {
    return json.encode(item.toJson());
  }

  @override
  LocationResponseModel deserialize(String data) {
    final jsonData = json.decode(data) as Map<String, dynamic>;
    return LocationResponseModel.fromJson(jsonData);
  }
}

/// Cache manager for single locations
class SingleLocationCacheManager extends BaseCacheManager<LocationModel> {
  SingleLocationCacheManager({
    required super.prefsService,
  }) : super(
          cacheValidDuration: const Duration(hours: 2),
          cachePrefix: 'LOCATION_ITEM_',
        );

  @override
  String serialize(LocationModel item) {
    return json.encode(item.toJson());
  }

  @override
  LocationModel deserialize(String data) {
    final jsonData = json.decode(data) as Map<String, dynamic>;
    return LocationModel.fromJson(jsonData);
  }
}

/// Cache manager for search results
class SearchCacheManager extends BaseCacheManager<LocationResponseModel> {
  SearchCacheManager({
    required super.prefsService,
  }) : super(
          cacheValidDuration: const Duration(minutes: 30), // Shorter for search
          cachePrefix: 'SEARCH_',
        );

  @override
  String serialize(LocationResponseModel item) {
    return json.encode(item.toJson());
  }

  @override
  LocationResponseModel deserialize(String data) {
    final jsonData = json.decode(data) as Map<String, dynamic>;
    return LocationResponseModel.fromJson(jsonData);
  }
}
