import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowing_reader/notifiers/theme_notifier.dart';
import 'pages/dashboard_page.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
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
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: (themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light()).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: themeNotifier.currentSeedColor),
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
    });
  }
}
