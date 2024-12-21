import 'package:flutter/material.dart';
import 'package:recipe_book/recipe.dart';

class HomeScreen extends StatelessWidget {
  final void Function(Recipe) onFavoriteTapped; // Add this line

  const HomeScreen(
      {super.key, required this.onFavoriteTapped}); // Update constructor

  Future<List<Recipe>> _loadRecipes(BuildContext context) async {
    List<Map<String, dynamic>> recipes = [
      {
        'name': 'Spaghetti Aglio e Olio',
        'ingredients':
            '1. 8 oz spaghetti\n2. 4 cloves garlic\n3. Red pepper flakes\n4. Salt\n5. Black pepper\n6. Fresh parsley',
        'instructions':
            '1. Cook spaghetti according to package instructions.\n2. In a pan, heat olive oil and add sliced garlic and red pepper flakes. Cook until garlic is golden.\n3. Toss cooked spaghetti in the garlic oil. Season with salt and pepper.\n4. Garnish with chopped fresh parsley. Serve.',
      },
      {
        'name': 'Caprese Salad',
        'ingredients':
            '1. Fresh tomatoes\n2. Fresh mozzarella cheese\n3. Fresh basil leaves\n4. Balsamic vinegar\n5. Extra-virgin olive oil\n6. Salt\n7. Black pepper',
        'instructions':
            '1. Arrange tomato and mozzarella slices on a plate.\n2. Tuck fresh basil leaves between the slices.\n3. Drizzle with balsamic vinegar and olive oil.\n4. Season with salt and pepper. Serve as an appetizer.',
      },
      {
        'name': 'Chicken Stir-Fry',
        'ingredients':
            '1. 1 lb chicken breast\n2. Assorted vegetables (bell peppers, broccoli, carrots)\n3. 2 cloves garlic\n4. Soy sauce\n5. Vegetable oil\n6. Honey',
        'instructions':
            '1. Heat vegetable oil in a pan. Add minced garlic and chicken slices. Cook until chicken is no longer pink.\n2. Add assorted vegetables and stir-fry until tender.\n3. In a small bowl, mix soy sauce and honey. Pour over the stir-fry.\n4. Cook for a few more minutes until the sauce thickens. Serve with rice.',
      },
      {
        'name': 'Grilled Cheese Sandwich',
        'ingredients':
            '1. 2 slices of bread\n2. Butter\n3. Slices of cheddar cheese',
        'instructions':
            '1. Butter one side of each bread slice.\n2. Place cheese between the slices with the buttered sides facing out.\n3. Heat a skillet over medium heat. Place the sandwich in the skillet.\n4. Cook until the bread is golden brown and the cheese is melted, flipping once. Serve hot.',
      },
      {
        'name': 'Greek Salad',
        'ingredients':
            '1. Cucumber\n2. Tomato\n3. Red onion\n4. Kalamata olives\n5. Feta cheese\n6. Fresh oregano (or dried oregano)\n7. Extra-virgin olive oil\n8. Red wine vinegar\n9. Salt\n10. Black pepper',
        'instructions':
            '1. In a large bowl, combine cucumber, tomato, red onion, olives, and feta cheese.\n2. Sprinkle with fresh or dried oregano.\n3. Drizzle with olive oil and red wine vinegar.\n4. Season with salt and pepper. Toss to combine. Serve as a side salad.',
      },
      {
        'name': 'Homemade Margherita Pizza',
        'ingredients':
            '1. Pizza dough\n2. Tomato sauce\n3. Fresh mozzarella cheese\n4. Fresh basil leaves\n5. Extra-virgin olive oil\n6. Salt\n7. Black pepper',
        'instructions':
            '1. Preheat your oven to the highest temperature it can go (usually around 500°F or higher).\n2. Roll out the pizza dough on a floured surface to your desired thickness.\n3. Transfer the dough to a baking sheet or pizza stone.\n4. Spread a thin layer of tomato sauce evenly over the dough.\n5. Tear fresh mozzarella cheese into pieces and distribute it on top of the sauce.\n6. Add fresh basil leaves on the cheese.\n7. Drizzle with extra-virgin olive oil and season with salt and black pepper.\n8. Bake in the preheated oven until the crust is golden and the cheese is bubbly and slightly browned (usually 10-15 minutes).\n9. Remove from the oven, let it cool for a minute, then slice and serve.'
      },
    ];

    return recipes
        .map((data) => Recipe(
              data['name'],
              data['ingredients'],
              data['instructions'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: const Text('Recipe Book'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _loadRecipes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<Recipe> recipes = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: {'recipe': recipe},
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.grey.shade400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.food_bank, size: 48.0),
                        const SizedBox(height: 8.0),
                        Text(
                          recipe.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No recipes available'),
            );
          }
        },
      ),
    );
  }
}
