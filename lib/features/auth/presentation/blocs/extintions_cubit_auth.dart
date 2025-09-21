import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/auth/domain/entities/lcation_entity.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';

extension LocationAuthCubitExtensions on AuthCubit {
  /// Get current locations list (either search results or normal locations)
  List<LocationEntity> get currentLocationsList {
    if (state.searchResults != null) {
      return state.searchResults!;
    }
    return state.locations?.locations ?? [];
  }

  /// Check if currently searching
  bool get isSearching {
    return state.currentSearchQuery != null &&
        state.currentSearchQuery!.isNotEmpty;
  }

  /// Check if loading
  bool get isLoading {
    return state.status == AppStatus.loading;
  }

  /// Check if has error
  bool get hasError {
    return state.status == AppStatus.failure;
  }

  /// Check if empty
  bool get isEmpty {
    return state.status == AppStatus.empty;
  }

  /// Check if success
  bool get isSuccess {
    return state.status == AppStatus.success;
  }

  /// Get error message
  String? get errorMessage {
    return hasError ? state.message : null;
  }

  /// Get success message

  String? get successMessage {
    return isSuccess ? state.message : null;
  }

  /// Get total locations count
  int get totalLocationsCount {
    if (isSearching) {
      return state.searchResults?.length ?? 0;
    }
    return state.locations!.pagination.total;
  }

  /// Check if can load more
  bool get canLoadMore {
    return !state.hasReachedMax! &&
        state.status != AppStatus.loading &&
        totalLocationsCount > 0;
  }
}
