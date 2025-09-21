class GetLocationByIdParams {
  final int id;

  const GetLocationByIdParams({
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetLocationByIdParams && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'GetLocationByIdParams(id: $id)';
}