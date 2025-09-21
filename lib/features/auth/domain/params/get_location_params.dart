class GetLocationsParams {
  final int page;

  const GetLocationsParams({
    required this.page,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetLocationsParams && other.page == page;
  }

  @override
  int get hashCode => page.hashCode;

  @override
  String toString() => 'GetLocationsParams(page: $page)';
}