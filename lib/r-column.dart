import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_food_otus/renderable.dart';

class RColumn extends Renderable {
  final List<Renderable> children;
  final List<Offset> offsets = [];

  RColumn({required this.children});

  @override
  void layout(BoxConstraints constraints) {
    double y = 0.0;
    offsets.clear();

    for (final child in children) {
      final childConstraints = BoxConstraints(
        minWidth: 0,
        maxWidth: constraints.maxWidth,
        minHeight: 0,
        maxHeight: constraints.maxHeight - y,
      );

      child.layout(childConstraints);

      if (child.size != null) {
        offsets.add(Offset(0, y));
        y += child.size!.height;
      }
    }

    final maxWidth = children
        .map((child) => child.size?.width ?? 0)
        .reduce(math.max);
    size = Size(maxWidth, y);
  }

  @override
  void render(ui.Canvas canvas, ui.Offset offset) {
    for (int i = 0; i < children.length; i++) {
      children[i].render(canvas, offsets[i] + offset);
    }
  }

  @override
  bool hitTest(Offset offset) {
    for (int i = 0; i < children.length; i++) {
      final childOffset = offsets[i];
      if (children[i].hitTest(offset - childOffset)) {
        return true;
      }
    }
    return false;
  }
}
