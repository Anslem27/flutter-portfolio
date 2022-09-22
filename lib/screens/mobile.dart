import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/mobile/mobile_homepage.dart';
import '../pages/web/snippet_webpage.dart';

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
                onTap: () {},
              ),
              DrawerItem(
                  title: "Snippets",
                  onTap: () => Navigator.pushNamed(context, "/snippets")),
              DrawerItem(
                title: "About",
                onTap: () => Navigator.pushNamed(context, "/about")
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

class DrawerItem extends StatelessWidget {
  final Function()? onTap;
  final String title;
  const DrawerItem({
    Key? key,
    this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: GoogleFonts.roboto(fontSize: 15),
            ),
            onTap: onTap,
          ),
          SizedBox(
            height: 5,
            child: Divider(
              height: 0.5,
              color: Colors.grey.shade800,
            ),
          )
        ],
      ),
    );
  }
}
