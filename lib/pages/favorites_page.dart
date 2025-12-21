import 'package:flutter/material.dart';
import 'package:flutter_amov2526/models/interest_point.dart';

import '../services/category_loader.dart';
import '../services/favorites_service.dart';
import 'interest_point_details_page.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<InterestPoint>> _favoritePoisFuture;

  @override
  void initState() {
    super.initState();
    _favoritePoisFuture = _loadFavoritePois();
  }

  Future<List<InterestPoint>> _loadFavoritePois() async {
    final favoritesService = FavoritesService();
    final favoriteIds = await favoritesService.getFavorites();

    if (favoriteIds.isEmpty) {
      return [];
    }

    final categories = await loadCategories();

    final List<InterestPoint> allPois = categories
        .expand((category) => category.pois)
        .toList();

    return allPois
        .where((poi) => favoriteIds.contains(poi.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InterestPoint>>(
      future: _favoritePoisFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Erro ao carregar favoritos'),
          );
        }

        final pois = snapshot.data!;

        if (pois.isEmpty) {
          return const Center(
            child: Text('Ainda não adicionou favoritos'),
          );
        }

        return ListView.builder(
          itemCount: pois.length,
          itemBuilder: (context, index) {
            final poi = pois[index];

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/${poi.imageUrl}',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(poi.name),
                subtitle: Text(poi.shortDescription),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PoiDetailsScreen(poi: poi),
                    ),
                  );

                  // Refresh when coming back
                  setState(() {
                    _favoritePoisFuture =
                        _loadFavoritePois();
                  });
                },
              ),
            );
          },
        );
      },
    );
  }
}