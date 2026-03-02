import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/green_light_theme.dart';
import 'package:flutter_food_otus/ui/recipes/recipes_page.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      testRemoteApi();
    });
    return MaterialApp(
      title: 'Otus Food',
      theme: GreenTheme.lightTheme,
      home: RecipesPage(),
    );
  }
}

Future<void> testRemoteApi() async {
  var client = http.Client();
  final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  final url = Uri.http('$host:4500');

  try {
    var response = await client.get(
      url,
      headers: {'connection-type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ('❌ Ошибка HTTP: ${response.statusCode}');
    }
    print('🔌 SocketException: OK');
  } on SocketException catch (e) {
    print('🔌 SocketException: ${e.message}');
  } catch (e) {
    print('❗ Ошибка: $e');
  } finally {
    client.close();
  }
}
