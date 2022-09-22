import 'package:flutter/material.dart';
import 'package:flutter_portfolio/pages/home.dart';
import 'package:flutter_portfolio/pages/web/about_webpage.dart';
import 'package:flutter_portfolio/pages/web/dashboard_webpage.dart';
import 'package:flutter_portfolio/pages/web/snippet_webpage.dart';
import 'package:flutter_portfolio/theme/app_theme.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/dashboard': (_) => const WebDashBoard(),
        '/snippets': (_) => const WebSnippetPage(),
        '/about': (_) => const WebAboutPage(),
      },
      title: 'My Portfolio',
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}
