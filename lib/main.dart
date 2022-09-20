import 'package:flutter/material.dart';
import 'package:flutter_portfolio/pages/home_view.dart';
import 'package:flutter_portfolio/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Portfolio',
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}
