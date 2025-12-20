import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_amov2526/models/interest_point.dart';

Future<List<InterestPoint>> loadPoIs() async {
  final jsonString = await rootBundle.loadString('assets/data/poi.json');
  final jsonData = json.decode(jsonString);

  final List list = jsonData['points_of_interest'];
  return list.map((e) => InterestPoint.fromJson(e))
      .toList();
}