import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web/web.dart';
import 'dart:ui_web' as ui_web;

class WebVideoPlayer extends StatelessWidget {
  final String id;
  final String minetype;
  final Uint8List bytes;

  const WebVideoPlayer({
    super.key,
    required this.id,
    required this.minetype,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    final sourceElement = HTMLSourceElement();
    sourceElement.type = minetype;
    sourceElement.src = Uri.dataFromBytes(bytes, mimeType: minetype).toString();
    final videoElement = HTMLVideoElement()
      ..id = id
      ..controls = true
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = 'auto'
      ..append(sourceElement);

    ui_web.platformViewRegistry.registerViewFactory(
      id,
      (int viewId) => videoElement,
    );

    return HtmlElementView(viewType: id);
  }
}
