class LinksModel {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  const LinksModel({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LinksModel &&
        other.first == first &&
        other.last == last &&
        other.prev == prev &&
        other.next == next;
  }

  @override
  int get hashCode {
    return first.hashCode ^ last.hashCode ^ prev.hashCode ^ next.hashCode;
  }

  @override
  String toString() {
    return 'LinksModel(first: $first, last: $last, prev: $prev, next: $next)';
  }
}