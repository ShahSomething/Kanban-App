class ApiCacheModel {
  ApiCacheModel({
    required this.endPoint,
    required this.cacheDuration,
  });

  factory ApiCacheModel.fromJson(Map<String, dynamic> json) => ApiCacheModel(
        endPoint: (json['end_point'] as String?) ?? '',
        cacheDuration: (json['cache_duration'] as int?) ?? 0,
      );
  final String? endPoint;
  final int? cacheDuration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['end_point'] = endPoint;
    map['cache_duration'] = cacheDuration;
    return map;
  }
}
