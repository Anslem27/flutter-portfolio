import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/mobile/mobile_homepage.dart';
import '../pages/web/about_webpage.dart';
import '../widgets/reusable/drawer_item.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: IconButton(
                  splashRadius: 24,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.light_mode_outlined,
                    size: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 10,
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 10,
        ),
        child: _mobileBody(),
      ),
      drawer: _mobileDrawer(context),
    );
  }

  Drawer _mobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 20),
                ),
              ),
              DrawerItem(
                title: "Home",
                onTap: () => Navigator.pop(context),
              ),
              DrawerItem(
                title: "DashBoard",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Switchpage(
                      route: '/dashboard',
                    ),
                  ),
                ),
              ),
              DrawerItem(
                title: "Snippets",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Switchpage(
                      route: '/snippets',
                    ),
                  ),
                ),
              ),
              DrawerItem(
                title: "About",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Switchpage(
                      route: '/about',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _mobileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Expanded(child: MobileHomePage()),
      ],
    );
  }
}

class Switchpage extends StatefulWidget {
  final String route;
  const Switchpage({super.key, required this.route});

  @override
  State<Switchpage> createState() => _SwitchpageState();
}

class _SwitchpageState extends State<Switchpage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () async {
        Navigator.pushReplacementNamed(context, widget.route);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset("assets/images/smear_loader.gif")),
      ),
    );
  }
}
