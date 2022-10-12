import 'package:flutter/material.dart';
import 'package:flutter_portfolio/animations/wavy_button.dart';

import '../pages/web/about_webpage.dart';
import '../pages/web/dashboard_webpage.dart';
import '../pages/web/snippet_webpage.dart';
import '../pages/web/web_homepage.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width / 5),
                _tabBar(),
                SizedBox(width: MediaQuery.of(context).size.width / 5),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: PlayButton(onPressed: () {}),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 4.8),
              ],
            ),
            //main app body
            Expanded(
              child: TabBarView(children: body),
            ),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return Expanded(
      child: TabBar(
        enableFeedback: true,
        indicator: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        tabs: const [
          Tab(
            text: "Home",
          ),
          Tab(
            text: "DashBoard",
          ),
          Tab(
            text: "Snippets",
          ),
          Tab(
            text: "About",
          )
        ],
      ),
    );
  }
}

List<Widget> body = [
  const HomePageView(),
  const WebDashBoard(),
  const WebSnippetPage(),
  const WebAboutPage()
];
