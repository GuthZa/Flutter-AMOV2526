import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_amov2526/models/category.dart';

Future<List<Category>> loadCategories() async {
  final jsonString = await rootBundle.loadString('assets/data/poi.json');
  final jsonData = json.decode(jsonString);

  final List list = jsonData['categories'];
  return list.map((c) => Category.fromJson(c)).toList();
}