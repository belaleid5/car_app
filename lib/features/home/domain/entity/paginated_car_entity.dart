import 'package:equatable/equatable.dart';

class PaginationMetaEntity extends Equatable {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;

 const PaginationMetaEntity({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
  
  @override
  List<Object?> get props => [
        currentPage,
        from,
        lastPage,
        path,
        perPage,
        to,
        total,
      ];
}