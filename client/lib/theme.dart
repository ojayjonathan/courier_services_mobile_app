import 'package:flutter/material.dart';

class ColorTheme {
  static Color primaryColor = Color(0xFF1E88E5);
  static const Color inputFill = Color(0xFFFBFBFB);
  static const Color borderColor = Color(0XFFCED0D2);
  static Color h1Color = Color(0xFF323643);
  static Color h2 = Color(0xFF606470);
  static final Color primary2Color = Color(0xff9FCCFA);
  static final Color primary3Color = Color(0xff3277D8);
  static final Color headerColor = Color(0xff343a40);
  static final Color textColor = Color(0xff495057);
  static final Color textColor2 = Color(0xff495057);
  static final Color accentColor = Color(0xffFF7D49);
  // static final Color backgroundColor = Color(0xffF1F3FA);
  static final Color backgroundColor = Color(0xffFFFFFF);
  static final Color lighBlueColor = Color(0xffCDDAFD);
  static final Color successColor = Color(0xff00A95E);
  static final Color muted = Color(0xff70757a);
  static final List<Color> dark = [
    Color(0xff212529),
    Color(0xff343a40),
    Color(0xff495057),
    Color(0xff6c757d)
  ];
}

class Styles {
  static ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(ColorTheme.primaryColor),
  );
}
