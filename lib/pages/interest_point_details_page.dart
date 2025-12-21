import 'package:flutter/material.dart';
import 'package:flutter_amov2526/models/interest_point.dart';
import 'package:flutter_amov2526/services/favorites_service.dart';

class PoiDetailsScreen extends StatefulWidget {
  final InterestPoint poi;

  const PoiDetailsScreen({super.key, required this.poi});

  @override
  State<PoiDetailsScreen> createState() => _PoiDetailsScreenState();
}

class _PoiDetailsScreenState extends State<PoiDetailsScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFav = await _favoritesService.isFavorite(widget.poi.id);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _toggleFavorite() async {
    await _favoritesService.toggleFavorite(widget.poi.id);
    setState(() {
      _isFavorite = !_isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? "Adicionado aos favoritos" : "Removido dos favoritos",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poi.name),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(_isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PoiImage(imagePath: "assets/${widget.poi.imageUrl}"),
            _PoiContent(poi: widget.poi),
          ],
        ),
      ),
    );
  }
}

class _PoiImage extends StatelessWidget {
  final String imagePath;

  const _PoiImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: double.infinity,
      height: 220,
      fit: BoxFit.cover,
    );
  }
}

class _PoiContent extends StatelessWidget {
  final InterestPoint poi;

  const _PoiContent({required this.poi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(poi.name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),

          _InfoRow(icon: Icons.schedule, text: poi.schedule),
          _InfoRow(icon: Icons.euro, text: poi.averagePrice),
          _InfoRow(icon: Icons.location_on, text: poi.location),

          const SizedBox(height: 16),
          Text(poi.description, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
