import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_food_otus/r-column.dart';
import 'package:flutter_food_otus/renderer.dart';

import 'colorful_rectangle.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final app = [
    ColorfulRectangle(
      color: const ui.Color.fromARGB(255, 231, 5, 5),
      preferredSize: const Size(300, 80),
    ),
    ColorfulRectangle(
      color: const ui.Color.fromARGB(255, 207, 230, 6),
      preferredSize: const Size(250, 120),
    ),
    ColorfulRectangle(
      color: const ui.Color.fromARGB(255, 76, 198, 76),
      preferredSize: const Size(200, 100),
    ),
  ];

  final rootEl = RColumn(children: app);
  Renderer(root: rootEl);
}
