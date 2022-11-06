import 'package:flutter/material.dart';
import 'package:flutter_portfolio/animations/wavy_button.dart';
import 'package:flutter_portfolio/pages/web/guestbook.dart';
import 'package:flutter_portfolio/theme/colors.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../pages/web/about_webpage.dart';
import '../pages/web/dashboard_webpage.dart';
import '../pages/web/web_homepage.dart';
import '../utils/appbar_logo.dart';

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
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: const NavBarLogo(),
                ),
                const SizedBox(width: 8),
                _tabBar(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: colors["primary"],
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: PlayButton(onPressed: () {}),
                    ),
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
      child: GlassmorphicContainer(
        width: double.maxFinite,
        height: 50,
        borderRadius: 8,
        alignment: Alignment.center,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.1),
              const Color(0xFFFFFFFF).withOpacity(0.1),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.transparent, Colors.transparent],
        ),
        border: 2,
        blur: 20,
        child: TabBar(
          enableFeedback: true,
          indicator: RectangularIndicator(
            color: Colors.grey.shade900,
            bottomRightRadius: 8,
            bottomLeftRadius: 8,
            topLeftRadius: 8,
            topRightRadius: 8,
            horizontalPadding: 5,
            verticalPadding: 5,
            paintingStyle: PaintingStyle.fill,
          ),
          tabs: const [
            Tab(
              text: "Home",
            ),
            Tab(
              text: "DashBoard",
            ),
            Tab(
              text: "GuestBook",
            ),
            // Tab(
            //   text: "Blog",
            // ),
            Tab(
              text: "About",
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> body = [
  const HomePageView(),
  const WebDashBoard(),
  const GuestBook(),
  //const SocialTab(),
  const WebAboutPage()
];
