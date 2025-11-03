import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/green_light_theme.dart';
import 'package:flutter_food_otus/ui/recipes/recipes_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otus Food',
      theme: GreenTheme.lightTheme,
      home: RecipesPage(),
    );
  }
}
