import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  Color _currentSeedColor = Colors.deepPurple;

  bool get isDarkMode => _isDarkMode;
  Color get currentSeedColor => _currentSeedColor;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateSeedColor(Color color) {
    _currentSeedColor = color;
    notifyListeners();
  }
}