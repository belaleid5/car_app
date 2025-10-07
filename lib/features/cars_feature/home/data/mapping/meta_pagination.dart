class PaginationMeta {
  final int currentPage;
  final int? from;
  final int lastPage;
  final String path;
  final int perPage;
  final int? to;
  final int total;

  const PaginationMeta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    this.to,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] as int,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      to: json['to'] as int?,
      total: json['total'] as int,
    );
  }

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
}
