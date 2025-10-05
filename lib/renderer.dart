import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_food_otus/renderable.dart';

class Renderer {
  Renderable root;
  late ui.PlatformDispatcher dispatcher;
  late ui.FlutterView view;

  Renderer({required this.root}) {
    dispatcher = ui.PlatformDispatcher.instance;
    view = dispatcher.views.first;
    _setupFrameCallbacks();
  }

  void _setupFrameCallbacks() {
    dispatcher.onBeginFrame = (timestamp) {};
    dispatcher.onDrawFrame = _drawFrame;
    dispatcher.onPointerDataPacket = _handlePointer;
  }

  void _drawFrame() {
    final width = view.physicalSize.width;
    final height = view.physicalSize.height;

    root.layout(BoxConstraints.tightFor(width: width, height: height));

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    root.render(canvas, ui.Offset.zero);
    final picture = recorder.endRecording();

    final sceneBuilder = ui.SceneBuilder();
    sceneBuilder.addPicture(ui.Offset.zero, picture);
    final scene = sceneBuilder.build();

    view.render(scene);
  }

  void _handlePointer(ui.PointerDataPacket packet) {
    final data = packet.data.firstWhere(
      (d) => d.change == ui.PointerChange.down,
      orElse: () => packet.data.first,
    );

    final localOffset = ui.Offset(data.physicalX, data.physicalY);

    if (root.hitTest(localOffset)) {
      dispatcher.scheduleFrame();
    }
  }
}
