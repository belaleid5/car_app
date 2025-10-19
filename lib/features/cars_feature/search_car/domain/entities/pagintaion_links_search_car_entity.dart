import 'package:equatable/equatable.dart';

class PaginationLinksEntity extends Equatable {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  const PaginationLinksEntity({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  @override
  List<Object?> get props => [first, last, prev, next];
}