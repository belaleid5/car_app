// lib/features/locations/data/datasources/location_remote_data_source.dart

import 'dart:async';
import 'package:car_app/core/constants/api_constants.dart';
import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/data/models/location-response-model.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/location_model.dart';



/// Contract for remote data source operations
abstract class LocationRemoteDataSource {
  /// Get paginated locations from remote API
  Future<LocationResponseModel> getLocations({required int page});
  
  /// Get a specific location by ID from remote API
  Future<LocationModel> getLocationById({required int id});
  
  /// Search locations by name from remote API
  Future<LocationResponseModel> searchLocations({
    required String query,
    required int page,
  });
}

/// Implementation of LocationRemoteDataSource using Dio
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final DioClient _dioClient;

  // API Endpoints
  static const String _locationsEndpoint = ApiConstants.locations;

  const LocationRemoteDataSourceImpl({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  @override
  Future<LocationResponseModel> getLocations({required int page}) async {
    try {
      print('🌐 [RemoteDS] Getting locations - Page: $page');

      final response = await _dioClient.dio.get(
        _locationsEndpoint,
        queryParameters: {'page': page},
      );

      print('✅ [RemoteDS] Locations received successfully');
      return LocationResponseModel.fromJson(response.data);

    } on DioException catch (e) {
      print('❌ [RemoteDS] Dio error getting locations: ${e.message}');
      throw _mapDioException(e);
    } catch (e) {
      print('❌ [RemoteDS] Unexpected error: $e');
      throw ServerException('خطأ غير متوقع في جلب المواقع: $e');
    }
  }

  @override
  Future<LocationModel> getLocationById({required int id}) async {
    try {
      print('🌐 [RemoteDS] Getting location by ID: $id');

      final response = await _dioClient.dio.get('$_locationsEndpoint$id');

      print('✅ [RemoteDS] Location by ID received successfully');
      return LocationModel.fromJson(response.data);

    } on DioException catch (e) {
      print('❌ [RemoteDS] Dio error getting location: ${e.message}');
      throw _mapDioException(e);
    } catch (e) {
      print('❌ [RemoteDS] Unexpected error: $e');
      throw ServerException('خطأ غير متوقع في جلب الموقع: $e');
    }
  }

  @override
  Future<LocationResponseModel> searchLocations({
    required String query,
    required int page,
  }) async {
    try {
      print('🔍 [RemoteDS] Searching locations - Query: "$query", Page: $page');

      final response = await _dioClient.dio.get(
        _locationsEndpoint,
        queryParameters: {
          'search': query.trim(),
          'page': page,
        },
      );

      print('✅ [RemoteDS] Search results received successfully');
      return LocationResponseModel.fromJson(response.data);

    } on DioException catch (e) {
      print('❌ [RemoteDS] Dio error searching: ${e.message}');
      throw _mapDioException(e);
    } catch (e) {
      print('❌ [RemoteDS] Unexpected error: $e');
      throw ServerException('خطأ غير متوقع في البحث: $e');
    }
  }

  /// Map Dio exceptions to custom exceptions
  Exception _mapDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return  TimeoutException('انتهت مهلة الاتصال، حاول مرة أخرى');

      case DioExceptionType.connectionError:
        return const NetworkException('لا يوجد اتصال بالإنترنت');

      case DioExceptionType.badResponse:
        return _handleBadResponse(dioError);

      case DioExceptionType.cancel:
        return const NetworkException('تم إلغاء الطلب');

      default:
        return ServerException('خطأ غير معروف: ${dioError.message}');
    }
  }

  /// Handle bad HTTP responses
  Exception _handleBadResponse(DioException dioError) {
    final statusCode = dioError.response?.statusCode;
    final errorMessage = _extractErrorMessage(dioError.response?.data);

    switch (statusCode) {
      case 400:
        return ServerException('طلب غير صحيح: $errorMessage', 400);
      case 404:
        return ServerException('المورد غير موجود', 404);
      case 500:
        return ServerException('خطأ في الخادم', 500);
      default:
        return ServerException('خطأ في الخادم ($statusCode)', statusCode);
    }
  }

  /// Extract error message from response
  String _extractErrorMessage(dynamic responseData) {
    try {
      if (responseData is Map<String, dynamic>) {
        return responseData['message'] ?? 
               responseData['error'] ?? 
               'خطأ غير محدد';
      }
      return responseData?.toString() ?? 'خطأ غير محدد';
    } catch (e) {
      return 'خطأ في تحليل رسالة الخطأ';
    }
  }
}