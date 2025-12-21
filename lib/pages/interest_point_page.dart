import 'package:flutter/material.dart';
import 'package:flutter_amov2526/models/category.dart';
import 'package:flutter_amov2526/pages/interest_point_details_page.dart';

import '../models/interest_point.dart';

class PoiListScreen extends StatelessWidget {
  final Category category;

  const PoiListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final pois = category.pois;

    return Scaffold(
      appBar: AppBar(title: const Text('Pontos de Interesse')),
      body: ListView.builder(
        itemCount: pois.length,
        itemBuilder: (context, index) {
          return InterestPointListTile(poi: pois[index]);
        },
      ),
    );
  }
}

class InterestPointListTile extends StatelessWidget {
  final InterestPoint poi;

  const InterestPointListTile({super.key, required this.poi});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            "assets/${poi.imageUrl}",
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(poi.name),
        subtitle: Text(poi.shortDescription),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PoiDetailsScreen(poi: poi)),
          );
        },
      ),
    );
  }
}
