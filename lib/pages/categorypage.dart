import 'package:flutter/material.dart';
import 'package:flutter_amov2526/models/icon_for_category.dart';
import 'package:flutter_amov2526/services/category_loader.dart';
import '../models/category.dart';
import 'interest_point_page.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: loadCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar as categorias!'));
        }

        final categories = snapshot.data!;
        if (categories.isEmpty) {
          return const Center(child: Text('Sem categorias.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: categories.length,
            //Creates a grid with equally sized and spaced tiles
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final Category category = categories[index];
              return _CategoryCard(category: category);
            },
          ),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;

  const _CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final icon = iconForCategory(category.name);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PoiListScreen(category: category)),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(category.name, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
