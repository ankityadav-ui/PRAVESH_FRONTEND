import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  // Dynamic Colors
  late Color backgroundColor;
  late Color boxColor;
  late Color whiteColor;
  late Color greenColor;

  ThemeProvider() {
    _updateColors();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    _updateColors();
    notifyListeners();
  }

  void _updateColors() {
    backgroundColor =
        isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF);
    boxColor = isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF1F1F1);
    whiteColor = isDarkMode ? Colors.white70 : Colors.black;
    greenColor = isDarkMode ? Colors.tealAccent : Colors.green;
  }
}
