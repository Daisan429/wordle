import 'package:flutter/material.dart';

class ThemeSwitch extends ChangeNotifier{
  bool isDark = false;

  setTheme({required bool turnOn}) {
    isDark = turnOn;
    notifyListeners();
  }
}