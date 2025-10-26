import 'package:flutter/material.dart';
import 'package:flutter_food_otus/domain/recipes_controller.dart';
import 'package:flutter_food_otus/repositories/fake_recipes_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RecipesController(repository: FakeRecipesRepository()).getRecipes();
    return MaterialApp(
      title: 'Home App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: const Center(child: Text('Hello, World!')),
      ),
    );
  }
}
