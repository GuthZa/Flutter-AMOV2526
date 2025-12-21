import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _key = 'favorite_pois';

  Future<Set<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.map(int.parse).toSet();
  }

  Future<void> toggleFavorite(int poiId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (favorites.contains(poiId)) {
      favorites.remove(poiId);
    } else {
      favorites.add(poiId);
    }

    prefs.setStringList(
      _key,
      favorites.map((e) => e.toString()).toList(),
    );
  }

  Future<bool> isFavorite(int poiId) async {
    final favorites = await getFavorites();
    return favorites.contains(poiId);
  }
}
