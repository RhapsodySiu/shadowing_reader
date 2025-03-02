import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowing_reader/notifiers/video_notifier.dart';

class VideoProviderContainer extends StatelessWidget {
  final Widget child;

  const VideoProviderContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoNotifier>(
      create: (_) => VideoNotifier(),
      child: child,
    );
  }
}