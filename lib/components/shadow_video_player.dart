import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadowing_reader/models/video.dart';
import 'package:video_player/video_player.dart';

class ShadowVideoPlayer extends StatefulWidget {
  const ShadowVideoPlayer({super.key, required this.video});

  final MyVideo video;

  @override
  State<ShadowVideoPlayer> createState() => _ShadowVideoPlayerState();
}

class _ShadowVideoPlayerState extends State<ShadowVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (kIsWeb) {
        _controller = VideoPlayerController.networkUrl(widget.video.webVideoUrl);
      } else {
        // print('Trying to init video: ${widget.fileSrc.path}');
        // _controller = VideoPlayerController.file(File(widget.fileSrc.path!));
        throw Exception('Video player not implemented for this platform');
      }
      
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Center(
        child: Text('Error: $_errorMessage'),
      );
    }

    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                _controller.seekTo(Duration.zero);
              },
            ),
          ],
        ),
        // Video progress indicator
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
  }
}