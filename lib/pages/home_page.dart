
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shadowing_reader/components/line_player_card.dart';

import '../shadow_video_player.dart';

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
  String _selectedOption = 'Purple Theme'; // Updated default option
  bool tempHasVideo = true;

  Future<void> _pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        withData: true,
      );

      if (result != null) {
        setState(() {
          _selectedVideo = result.files.first;
        });
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
            const SizedBox(height: 16), // Add spacing between buttons
            ElevatedButton(
              onPressed: _showOptionsDialog,
              child: Text('Select Theme: $_selectedOption'),
            ),
            if (_selectedVideo != null)
              ShadowVideoPlayer(fileSrc: _selectedVideo!)
          ],
        ),
      );
  }

  _buildPlayerPage() {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return LinePlayerCard();
          },
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: Container(
            width: 160,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Video Player',
                style: TextStyle(color: Colors.white),
              ),
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
