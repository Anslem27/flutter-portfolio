// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/reusable/chip_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;
import '../pages/web/social_tab.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _footerBody(context);
  }

  _footerBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width / 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _footerItem("Twitter", () {
              js.context.callMethod('open', ["https://twitter.com/anslemAnsy"]);
            }),
            _footerItem("Reddit", () {
              js.context.callMethod(
                  'open', ["https://www.reddit.com/user/Infamous-Date-355"]);
            }),
            _footerItem("Github", () {
              js.context.callMethod('open', ["https://github.com/Anslem27"]);
            }),
            _footerItem("Tweets", () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => const SocialTab(),
                ),
              );
            }),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4),
          child: ChipText(
            text: "Dont Forget to sign in to Guestbook.",
            color: Colors.deepPurple,
          ),
        ),
        SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("Made with 🤟♥ in Flutter"),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 50),
            ],
          ),
        )
      ],
    );
  }

  _footerItem(String title, Function()? onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: GoogleFonts.ubuntu(color: Colors.grey.shade800, fontSize: 16),
        ),
      ),
    );
  }
}
