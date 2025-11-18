import 'package:equatable/equatable.dart';

class DetailsPaginationMetaEntity extends Equatable {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;

  const DetailsPaginationMetaEntity({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
  });

  /// Business Logic: هل يوجد صفحة تالية؟
  bool get hasNextPage => currentPage < lastPage;
  
  /// Business Logic: هل يوجد صفحة سابقة؟
  bool get hasPreviousPage => currentPage > 1;

  @override
  List<Object?> get props => [currentPage, lastPage, perPage, total, from, to];
}