import 'package:car_app/features/auth/data/models/meta_links_model.dart';
import 'package:car_app/features/auth/domain/entities/pagination_entity.dart';

class MetaModel {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;
  final List<MetaLinkModel>? links;

  const MetaModel({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
    this.links,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'] as int,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      to: json['to'] as int,
      total: json['total'] as int,
      links: json['links'] != null
          ? (json['links'] as List<dynamic>)
              .map((link) => MetaLinkModel.fromJson(link as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
      'links': links?.map((link) => link.toJson()).toList(),
    };
  }

  /// Convert to PaginationEntity
  PaginationEntity toPaginationEntity() {
    return PaginationEntity(
      currentPage: currentPage,
      lastPage: lastPage,
      total: total,
      perPage: perPage,
      from: from,
      to: to,
      path: path,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetaModel &&
        other.currentPage == currentPage &&
        other.from == from &&
        other.lastPage == lastPage &&
        other.path == path &&
        other.perPage == perPage &&
        other.to == to &&
        other.total == total;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        from.hashCode ^
        lastPage.hashCode ^
        path.hashCode ^
        perPage.hashCode ^
        to.hashCode ^
        total.hashCode;
  }

  @override
  String toString() {
    return 'MetaModel(currentPage: $currentPage, lastPage: $lastPage, total: $total, perPage: $perPage)';
  }
}