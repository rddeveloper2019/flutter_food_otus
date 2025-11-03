import 'package:flutter/material.dart';
import 'package:flutter_food_otus/domain/recipes_controller.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/repositories/fake_recipes_repository.dart';
import 'package:flutter_food_otus/ui/recipes/recipes_list_item.dart';

class RecipesPage extends StatelessWidget {
  RecipesPage({super.key});

  final _controller = RecipesController(repository: FakeRecipesRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Otus Food')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _controller.getRecipes(),
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.done) {
            return Center(child: const CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          final recipes = snapshot.data ?? [];

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              return RecipesListItem(recipe: recipes[index]);
            },
            separatorBuilder: (_, _) {
              return SizedBox(height: 24);
            },
          );
        },
      ),
    );
  }
}
