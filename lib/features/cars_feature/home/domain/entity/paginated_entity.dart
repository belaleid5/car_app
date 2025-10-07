import 'package:equatable/equatable.dart';

class PaginationEntity<T> extends Equatable {
  final List<T> data;
  final String? nextLink;
  final String? prevLink;
  final int currentPage;
  final int lastPage;
  final int total;

  const PaginationEntity({
    required this.data,
    this.nextLink,
    this.prevLink,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  @override
  List<Object?> get props => [data, nextLink, prevLink, currentPage, lastPage, total];
}