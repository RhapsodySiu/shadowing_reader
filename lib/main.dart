import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(
              title: 'Shadowing Player Test',
              onThemeChanged: _updateSeedColor,
            ),
        '/settings': (context) => const SettingsPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
