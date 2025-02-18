import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shadowing_reader/shadow_video_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _currentSeedColor = Colors.deepPurple;

  void _updateSeedColor(String option) {
    setState(() {
      switch (option) {
        case 'Purple Theme':
          _currentSeedColor = Colors.deepPurple;
        case 'Green Theme':
          _currentSeedColor = Colors.green;
        case 'Blue Theme':
          _currentSeedColor = Colors.blue;
        case 'Red Theme':
          _currentSeedColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _currentSeedColor),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        onThemeChanged: _updateSeedColor,
      ),
    );
  }
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
  String _selectedOption = 'Purple Theme'; // Updated default option

  Future<void> _pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
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
      ),
      body: Center(
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
      ),
    );
  }
}
