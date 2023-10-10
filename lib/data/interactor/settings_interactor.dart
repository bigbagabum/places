import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/themes.dart';

class ThemeInteractor extends ChangeNotifier {
  ThemeData _data = lightTheme;
  static bool isBlack = false;

  ThemeData get currentTheme => _data;

  void changeTheme(bool newTheme) {
    _data = newTheme ? darkTheme : lightTheme;
    newTheme ? {isBlack = true} : {isBlack = false};

    notifyListeners();
  }
}
