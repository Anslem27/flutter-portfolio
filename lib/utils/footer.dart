import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

//TODO: Change text color onhover on footer items, plus format code to reduce redundancy
class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth < 600) {
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
                  js.context
                      .callMethod('open', ["https://twitter.com/anslemAnsy"]);
                }),
                _footerItem("Reddit", () {
                  js.context.callMethod('open',
                      ["https://www.reddit.com/user/Infamous-Date-355"]);
                }),
                _footerItem("Github", () {
                  js.context
                      .callMethod('open', ["https://github.com/Anslem27"]);
                }),
              ],
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
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Home",
                          style: GoogleFonts.roboto(
                              color: Colors.grey.shade800, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Spotify",
                          style: GoogleFonts.roboto(
                              color: Colors.grey.shade800, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 6),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _footerItem("Twitter", () {
                        js.context.callMethod(
                            'open', ["https://twitter.com/anslemAnsy"]);
                      }),
                      _footerItem("Reddit", () {
                        js.context.callMethod('open',
                            ["https://www.reddit.com/user/Infamous-Date-355"]);
                      }),
                      _footerItem("Github", () {
                        js.context.callMethod(
                            'open', ["https://github.com/Anslem27"]);
                      }),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 6),
                Flexible(
                  child: _footerItem("Bio", () {
                    //js.context.callMethod('open', [""]);
                  }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 5),
              ],
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
                    children: const [Text("Made with 🤟♥ in Flutter")],
                  )
                ],
              ),
            )
          ],
        );
      }
    });
  }

  _footerItem(String title, Function()? onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: GoogleFonts.roboto(color: Colors.grey.shade800, fontSize: 16),
        ),
      ),
    );
  }
}
