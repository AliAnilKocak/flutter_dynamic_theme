import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  Color _themeData;

  ThemeNotifier(this._themeData);

  getColor() => _themeData;

  setColor(Color themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
