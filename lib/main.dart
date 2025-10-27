import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/green_light_theme.dart';
import 'package:flutter_food_otus/domain/recipes_controller.dart';
import 'package:flutter_food_otus/repositories/fake_recipes_repository.dart';
import 'package:flutter_food_otus/ui/recipes/recipes_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otus Food',
      home: RecipesPage(),
      theme: GreenTheme.lightTheme,
    );
  }
}
