import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowing_reader/container/video_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: (themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light())
            .copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: themeNotifier.currentSeedColor,
            brightness:
                themeNotifier.isDarkMode ? Brightness.dark : Brightness.light,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const VideoProviderContainer(
              child: MyHomePage(title: 'Shadowing Reader')),
          '/settings': (context) => const SettingsPage(),
          '/dashboard': (context) => const DashboardPage(),
        },
      );
    });
  }
}
