import 'package:flutter/material.dart';
import 'package:flutter_amov2526/services/InterestPointLoader.dart';

import '../models/interest_point.dart';

class PoiListScreen extends StatefulWidget {
  final String categoryId;

  const PoiListScreen({super.key, required this.categoryId});

  @override
  State<PoiListScreen> createState() => _PoiListScreenState();
}

class _PoiListScreenState extends State<PoiListScreen> {
  late Future<List<InterestPoint>> _poisfuture;

  @override
  void initState() {
    super.initState();
    _poisfuture = loadPoIs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pontos de Interesse')),
      body: FutureBuilder<List<InterestPoint>>(
        future: _poisfuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os pontos de interesse'),
            );
          }

          final filteredPois = snapshot.data!
              .where((poi) => poi.category == widget.categoryId)
              .toList();

          if (filteredPois.isEmpty) {
            return const Center(
              child: Text('Sem pontos de interesse nesta categoria'),
            );
          }

          return ListView.builder(
            itemCount: filteredPois.length,
            itemBuilder: (context, index) {
              return InterestPointListTile(poi: filteredPois[index]);
            },
          );
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
            poi.imageUrl,
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
          // Navigator.push → PoiDetailScreen (next step)
        },
      ),
    );
  }
}
