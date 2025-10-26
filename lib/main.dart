import 'package:flutter/material.dart';
import 'package:flutter_food_otus/ui/recipes/recipes_controller.dart';
import 'package:flutter_food_otus/repositories/fake_recipes_repository.dart';
import 'package:flutter_food_otus/ui/recipes/recipes_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Home App', home: RecipesPage());
  }
}
