import 'package:flutter_amov2526/models/interest_point.dart';

class Category {
  final String name;
  final List<InterestPoint> pois;

  const Category({
    required this.name,
    required this.pois,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      pois: (json['points'] as List)
          .map((e) => InterestPoint.fromJson(e))
          .toList(),
    );
  }
}
