class MetaLinkModel {
  final String? url;
  final String label;
  final bool active;

  const MetaLinkModel({
    this.url,
    required this.label,
    required this.active,
  });

  factory MetaLinkModel.fromJson(Map<String, dynamic> json) {
    return MetaLinkModel(
      url: json['url'] as String?,
      label: json['label'] as String,
      active: json['active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetaLinkModel &&
        other.url == url &&
        other.label == label &&
        other.active == active;
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;

  @override
  String toString() {
    return 'MetaLinkModel(url: $url, label: $label, active: $active)';
  }
}
