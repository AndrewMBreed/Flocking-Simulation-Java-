import 'package:flutter/material.dart';

class themeOptions{
  final List<Color> bright = [Colors.white,Colors.grey.shade400,Colors.grey.shade700,Colors.blue,Colors.red, Colors.black];
  final List<Color> dark = [Colors.grey.shade900,Colors.orange.shade800,Colors.grey.shade800,Colors.orange.shade500,Colors.red.shade800, Colors.grey.shade300, Colors.black];
  final List<Color> blue = [];
  final List<Color> orange = [];
}

class theme {
  static Color primaryColor = Colors.black;
  static Color secondaryColor = Colors.black;
  static Color tertiaryColor = Colors.black;
  static Color acceptColor = Colors.black;
  static Color denyColor = Colors.red;
  static Color textColor = Colors.black;
  static Color textButtonColor = Colors.black;

  static void setTheme(List<Color> inputTheme) {
    primaryColor = inputTheme[0];
    secondaryColor = inputTheme[1];
    tertiaryColor = inputTheme[2];
    acceptColor = inputTheme[3];
    denyColor = inputTheme[4];
    textColor = inputTheme[5];
    textButtonColor = inputTheme[6];
  }
}