import 'package:flutter/material.dart';
import 'colors.dart';

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

  static final ThemeData lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Color(0xff000000)),
    appBarTheme: AppBarTheme(
      color: const Color(0xfff0e7db).withOpacity(0.5),
    ),
    cardColor: Colors.grey.shade900,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: lightCream,
    primaryColor: const Color(0xfff0e7db).withOpacity(0.5),
    brightness: Brightness.light,
  );
}
