import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/home/domain/entity/brands_entity.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final AppStatus status;
  final List<BrandEntity> brands;
  final String? errorMessage;
  final int currentPage;
  final bool hasReachedMax;

  const HomeState({
    this.status = AppStatus.initial,
    this.brands = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  HomeState copyWith({
    AppStatus? status,
    List<BrandEntity>? brands,
    String? errorMessage,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        brands,
        errorMessage,
        currentPage,
        hasReachedMax,
      ];
}
