import 'package:flutter/material.dart';
import 'package:recipe_book/homescreen.dart';
import 'package:recipe_book/favorites_screen.dart';
import 'package:recipe_book/recipe.dart';
import 'package:recipe_book/details.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatefulWidget {
  const RecipeBookApp({super.key});

  @override
  State<RecipeBookApp> createState() => _RecipeBookAppState();
}

class _RecipeBookAppState extends State<RecipeBookApp> {
  final List<Recipe> favoriteRecipes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(onFavoriteTapped: _handleFavoriteTapped),
        '/details': (context) => DetailsScreen(
            onFavoriteTapped: _handleFavoriteTapped,
            favorites: favoriteRecipes),
        '/favorites': (context) => FavoritesScreen(favorites: favoriteRecipes),
      },
    );
  }

  void _handleFavoriteTapped(Recipe recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }
}
