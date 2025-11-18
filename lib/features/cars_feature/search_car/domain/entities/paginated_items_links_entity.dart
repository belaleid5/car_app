import 'package:equatable/equatable.dart';

class PaginationLinkItemEntity extends Equatable {
  final String? url;
  final String label;
  final bool active;

  const PaginationLinkItemEntity({
    this.url,
    required this.label,
    required this.active,
  });

  @override
  List<Object?> get props => [url, label, active];
}