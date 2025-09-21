class PaginationEntity {
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;
  final int from;
  final int to;
  final String path;

  const PaginationEntity({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
    required this.from,
    required this.to,
    required this.path,
  });

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
  bool get isFirstPage => currentPage == 1;
  bool get isLastPage => currentPage == lastPage;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginationEntity &&
        other.currentPage == currentPage &&
        other.lastPage == lastPage &&
        other.total == total &&
        other.perPage == perPage &&
        other.from == from &&
        other.to == to &&
        other.path == path;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        lastPage.hashCode ^
        total.hashCode ^
        perPage.hashCode ^
        from.hashCode ^
        to.hashCode ^
        path.hashCode;
  }

  @override
  String toString() {
    return 'PaginationEntity(currentPage: $currentPage, lastPage: $lastPage, total: $total, perPage: $perPage)';
  }
}
