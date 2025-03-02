import 'dart:js_interop';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowing_reader/components/shadow_video_player.dart';
import 'package:shadowing_reader/container/video_provider.dart';
import 'package:shadowing_reader/models/video.dart';
import 'package:shadowing_reader/notifiers/video_notifier.dart';
import 'package:web/web.dart' as web;
import 'package:shadowing_reader/components/line_player_card.dart';

_getMimetypeByExtension(String? extension) {
  switch (extension) {
    case 'mp4':
      return 'video/mp4';
    case 'webm':
      return 'video/webm';
    case 'ogg':
      return 'video/ogg';
    default:
      return 'video/mp4';
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _pickVideo() async {
    try {
      final videoNotifier = context.read<VideoNotifier>();

      if (kIsWeb) {
        web.HTMLInputElement input = web.HTMLInputElement()..type = 'file';
        input.click();

        await input.onChange.first;
        if (input.files != null && (input.files?.length ?? 0) > 0) {
          final file = input.files!.item(0);
          
          if (!file.isUndefinedOrNull) {
            debugPrint(file!.size.toString());
            final objectUrl = web.URL.createObjectURL(file);

            videoNotifier.setWebVideo(MyVideo(title: file.name, thumbnail: '', webVideoUrl: Uri.dataFromString(objectUrl)));
          } else {
            throw Exception('File is null or undefined');
          }
        }
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.video,
          withData: false,
          withReadStream: true,
        );

        if (result != null) {
          final file = result.files.first;

          if (file.readStream != null) {
            // final bytes = await _readStreamToBytes(file.readStream!);

            // TODO set selected video
          } else {
            throw Exception('File read stream is null');
          }
        }
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

  _buildSelectPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: _pickVideo,
            child: const Text('Select Video'),
          ),
        ],
      ),
    );
  }

  _buildPlayerPage() {
    final VideoNotifier videoNotifier = Provider.of<VideoNotifier>(context);

    if (!videoNotifier.hasVideo) {
      throw Exception('Unaccessible code: videoNotifier has no video');
    }

    final test = Theme.of(context);
    debugPrint(test.toString());
    return Stack(
      children: [
        ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return LinePlayerCard(
              isActive: index == 3,
            );
          },
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: Container(
            width: 640,
            height: 480,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ShadowVideoPlayer(video: videoNotifier.video),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoNotifier>(
      builder: (context, videoNotifier, child) => Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
          ),
          IconButton(
          icon: const Icon(Icons.dashboard),
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          },
          ),
        ],
        ),
        body: videoNotifier.hasVideo ? _buildPlayerPage() : _buildSelectPage(),
      ),
      );
  }
}
