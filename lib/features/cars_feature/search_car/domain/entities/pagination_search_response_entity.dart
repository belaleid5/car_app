import 'package:equatable/equatable.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/car_repsone_search_entity.dart';

class PaginationResponseSearchEntity extends Equatable {
  final List<CarSearchEntityResponse> cars;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginationResponseSearchEntity({
    required this.cars,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    this.hasNextPage = false,
    this.hasPreviousPage = false,
  });

  @override
  List<Object?> get props => [
        cars,
        currentPage,
        totalPages,
        totalItems,
        hasNextPage,
        hasPreviousPage,
      ];

  PaginationResponseSearchEntity copyWith({
    List<CarSearchEntityResponse>? cars,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return PaginationResponseSearchEntity(
      cars: cars ?? this.cars,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }
}
