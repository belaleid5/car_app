import 'dart:async';

import 'package:car_app/core/error/faliure.dart';
import 'package:car_app/features/auth/data/data_sources/location_remote_datasource.dart';
import 'package:car_app/features/auth/data/data_sources/location_local_datasource.dart';
import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:car_app/features/auth/domain/entities/location_page_entity.dart';
import 'package:car_app/features/auth/domain/repositories/location_repos.dart';
import 'package:dartz/dartz.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final LocationLocalDataSource localDataSource;

  const LocationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, LocationPageEntity>> getLocations({
    required int page,
  }) async {
    try {
      // Try to get from cache first
      try {
        final cachedResponse = await localDataSource.getCachedLocationResponse(page);
        return Right(cachedResponse.toEntity());
      } on CacheException {
        // Cache miss or expired, continue to remote
      }

      // Get from remote
      final remoteResponse = await remoteDataSource.getLocations(page: page);
      
      // Cache the response
      await localDataSource.cacheLocationResponse(remoteResponse, page);
      
      return Right(remoteResponse.toEntity());
      
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message,  e.hashCode));
    } on NetworkException catch (e) {
      // Try to get from cache if network fails
      try {
        final cachedResponse = await localDataSource.getCachedLocationResponse(page);
        return Right(cachedResponse.toEntity());
      } on CacheException {
        return Left(NetworkFailure( e.message,  e.hashCode));
      }
    } on TimeoutException catch (e) {
      return Left(NetworkFailure( e.message!,  e.hashCode));
    } catch (e) {
      return Left(ServerFailure( 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getLocationById({
    required int id,
  }) async {
    try {
      // Try to get from cache first
      try {
        final cachedLocation = await localDataSource.getCachedLocation(id);
        return Right(cachedLocation.toEntity());
      } on CacheException {
        // Cache miss or expired, continue to remote
      }

      // Get from remote
      final remoteLocation = await remoteDataSource.getLocationById(id: id);
      
      // Cache the location
      await localDataSource.cacheLocation(remoteLocation);
      
      return Right(remoteLocation.toEntity());
      
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message,  e.hashCode));
    } on NetworkException catch (e) {
      // Try to get from cache if network fails
      try {
        final cachedLocation = await localDataSource.getCachedLocation(id);
        return Right(cachedLocation.toEntity());
      } on CacheException {
        return Left(NetworkFailure( e.message,  e.hashCode));
      }
    } on TimeoutException catch (e) {
      return Left(NetworkFailure( e.message!,  e.hashCode));
    } catch (e) {
      return Left(ServerFailure( 'Unexpected error: $e'));
    }
  }

  Future<Either<Failure, LocationPageEntity>> searchLocations({
    required String query,
    required int page,
  }) async {
    try {
      // Search doesn't use cache as results may vary frequently
      final remoteResponse = await remoteDataSource.searchLocations(
        query: query,
        page: page,
      );
      
      return Right(remoteResponse.toEntity());
      
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message, ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure( e.message, ));
    } on TimeoutException catch (e) {
      return Left(NetworkFailure( e.message!, ));
    } catch (e) {
      return Left(ServerFailure( 'Unexpected error: $e'));
    }
  }
}