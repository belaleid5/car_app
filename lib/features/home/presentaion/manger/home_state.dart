import 'package:car_app/features/home/domain/entity/brands_entity.dart';
import 'package:car_app/features/home/domain/entity/car_entity.dart';
import 'package:car_app/features/home/domain/entity/paginated_car_entity.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/enums/app_states.dart';

class HomeState extends Equatable {
  final AppStatus status;
  final List<BrandEntity> brands;
  final List<CarEntity> bestCars;
  final PaginationMetaEntity? carsMeta;
  final String? errorMessage;
  final int currentPage;
  final bool hasReachedMax;

  const HomeState({
    this.status = AppStatus.initial,
    this.brands = const [],
    this.bestCars = const [],
    this.carsMeta,
    this.errorMessage,
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  HomeState copyWith({
    AppStatus? status,
    List<BrandEntity>? brands,
    List<CarEntity>? bestCars,
    PaginationMetaEntity? carsMeta,
    String? errorMessage,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      bestCars: bestCars ?? this.bestCars,
      carsMeta: carsMeta ?? this.carsMeta,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        brands,
        bestCars,
        carsMeta,
        errorMessage,
        currentPage,
        hasReachedMax,
      ];
}
