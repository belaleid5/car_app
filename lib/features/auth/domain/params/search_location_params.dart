class SearchLocationsParams {
  final String query;
  final int page;

  const SearchLocationsParams({
    required this.query,
    required this.page,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchLocationsParams &&
        other.query == query &&
        other.page == page;
  }

  @override
  int get hashCode => query.hashCode ^ page.hashCode;

  @override
  String toString() => 'SearchLocationsParams(query: $query, page: $page)';
}