import 'package:flutter/material.dart';
import 'package:music_player/themes/dark_mode.dart';
import 'package:music_player/themes/ligth_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initialize , ligth mode
  ThemeData _themeData = ligthMode;

  // get theme
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // update UI
    notifyListeners();
  }

  // toggle themes
  void toggleTheme() {
    if (_themeData == ligthMode) {
      // is ligth set it to dark Mode
      themeData = darkMode;
    } else {
      themeData = ligthMode;
    }
  }
}
