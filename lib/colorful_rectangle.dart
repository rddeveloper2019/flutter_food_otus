import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_food_otus/renderable.dart';

class ColorfulRectangle extends Renderable {
  ui.Color color;
  final ui.Size preferredSize;

  ColorfulRectangle({
    required this.color,
    this.preferredSize = const ui.Size(200, 100),
  });

  @override
  void layout(BoxConstraints constraints) {
    final width = preferredSize.width.clamp(
      constraints.minWidth,
      constraints.maxWidth,
    );
    final height = preferredSize.height.clamp(
      constraints.minHeight,
      constraints.maxHeight,
    );
    size = ui.Size(width, height);
  }

  @override
  void render(ui.Canvas canvas, ui.Offset offset) {
    if (size == null) return;

    final rect = ui.Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size!.width,
      size!.height,
    );

    final paint = ui.Paint()
      ..color = color
      ..style = ui.PaintingStyle.fill;

    canvas.drawRect(rect, paint);

    final borderPaint = ui.Paint()
      ..color = ui.Color.fromARGB(255, 0, 0, 0)
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(rect, borderPaint);
  }

  @override
  bool hitTest(ui.Offset offset) {
    if (size != null &&
        offset.dx >= 0 &&
        offset.dy >= 0 &&
        offset.dx < size!.width &&
        offset.dy < size!.height) {
      color = ui.Color.fromARGB(
        255,
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      );
      return true;
    }
    return false;
  }
}
