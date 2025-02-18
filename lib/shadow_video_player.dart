import 'dart:io';
import 'dart:typed_data';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

@JS("Blob")
extension type Blob._(JSObject _) implements JSObject {
  external factory Blob(JSArray<JSArrayBuffer> blobParts, JSObject? options);
  
  factory Blob.fromBytes(List<int> bytes) {
    final data = Uint8List.fromList(bytes).buffer.toJS;
    return Blob([data].toJS, null);
  }
  
  external JSArrayBuffer? get blobParts;
  external JSObject? get options;
}

class ShadowVideoPlayer extends StatefulWidget {
  const ShadowVideoPlayer({super.key, required this.fileSrc});

  final PlatformFile fileSrc;

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
      print('Trying to init video: ${widget.fileSrc.path}');

      if (kIsWeb) {
        // Get bytes from PlatformFile widget.fileSrc
        // final bytes = await File(widget.fileSrc.path!).readAsBytes();
        
        // // Create web.JSArray from the bytes
        // final jsArray = web.JSArray.from(List<int>.from(bytes));
        
        // // Create web.Blob from js array obtained
        // final blob = web.Blob([jsArray]);
        
        // // Create object url from web.Blob 
        // final url = web.Url.createObjectUrlFromBlob(blob);
      } else {
        _controller = VideoPlayerController.file(File(widget.fileSrc.path!));
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