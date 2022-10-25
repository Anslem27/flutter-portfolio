import 'package:flutter/material.dart';
import '../views/mobile.dart';
import '../views/webview.dart';
import '../widgets/responsive_layout.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.black,
      body: ResponsiveWidget(
        mobile: MobileView(),
        webview: WebView(),
      ),
    );
  }
}
