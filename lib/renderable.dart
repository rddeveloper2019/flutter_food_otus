import 'package:flutter/rendering.dart';

abstract class Renderable {
  Size? size;

  void layout(BoxConstraints constraints);
  void render(Canvas canvas, Offset offset);
  bool hitTest(Offset offset);
}
