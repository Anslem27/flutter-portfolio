import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/pages/home.dart';
import 'package:flutter_portfolio/pages/web/about_webpage.dart';
import 'package:flutter_portfolio/pages/web/dashboard_webpage.dart';
import 'package:flutter_portfolio/pages/web/guestbook.dart';
import 'package:flutter_portfolio/theme/app_theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // binds all functions before calling main app
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/dashboard': (_) => const WebDashBoard(),
        '/about': (_) => const WebAboutPage(),
        '/guestbook': (_) => const GuestBook(),
      },
      title: 'My Portfolio',
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}
