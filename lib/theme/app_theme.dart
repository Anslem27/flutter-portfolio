import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    iconTheme: const IconThemeData(color: Color(0xfff8f8ff)),
    appBarTheme: AppBarTheme(color: Colors.grey.shade900),
    cardColor: Colors.grey.shade900,
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: darkColor,
    primaryColor: Colors.grey.shade900,
    brightness: Brightness.dark,
  );
}

//custom black material color
MaterialColor darkColor = const MaterialColor(
  0xff000000,
  <int, Color>{
    50: Color(0xff000000),
    100: Color(0xff000000),
    200: Color(0xff000000),
    300: Color(0xff000000),
    400: Color(0xff000000),
    500: Color(0xff000000),
    600: Color(0xff000000),
    700: Color(0xff000000),
    800: Color(0xff000000),
    900: Color(0xff000000),
  },
);
