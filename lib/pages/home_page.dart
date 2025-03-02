
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadowing_reader/components/line_player_card.dart';
import 'package:shadowing_reader/components/web_video_player.dart';


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

Future<Uint8List> _readStreamToBytes(Stream<List<int>> stream) async {
  final chunks = <List<int>>[];
  int length = 0;
  
  await for (final chunk in stream) {
    chunks.add(chunk);
    length += chunk.length;
  }
  
  // Concatenate all chunks into a single Uint8List
  final result = Uint8List(length);
  int offset = 0;
  for (final chunk in chunks) {
    result.setRange(offset, offset + chunk.length, chunk);
    offset += chunk.length;
  }
  
  return result;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onThemeChanged,
  });

  final String title;
  final void Function(String) onThemeChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PlatformFile? _selectedVideo;
  bool tempHasVideo = false;

  Future<void> _pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        withData: false,
        withReadStream: true,
      );

      if (result != null) {
        final file = result.files.first;

        if (file.readStream != null) {
          // final bytes = await _readStreamToBytes(file.readStream!);

          setState(() {
            _selectedVideo = file;
            tempHasVideo = true;
          });
        } else {
          throw Exception('File read stream is null');
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
                child: WebVideoPlayer(
                  id: 'TEST',
                  minetype: _getMimetypeByExtension(_selectedVideo?.extension),
                  bytes: _selectedVideo?.bytes ?? Uint8List(0),
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _showOptionsDialog() async {
    final options = ['Purple Theme', 'Green Theme', 'Blue Theme', 'Red Theme'];

    final choice = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: SingleChildScrollView(
            child: ListBody(
              children: options.map((option) {
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    Navigator.of(context).pop(option);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (choice != null) {
      setState(() {
        _selectedOption = choice;
      });
      widget.onThemeChanged(choice); // Notify parent widget about the change
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: tempHasVideo ? _buildPlayerPage() : _buildSelectPage(),
    );
  }
}
