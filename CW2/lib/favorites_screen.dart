import 'package:flutter/material.dart';
import 'package:recipe_book/recipe.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final recipe = favorites[index];
          return ListTile(
            title: Text(recipe.name),
            subtitle: Text(recipe.ingredients),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: {'recipe': recipe},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
