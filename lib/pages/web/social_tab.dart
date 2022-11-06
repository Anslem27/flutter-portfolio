// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import '../../utils/footer.dart';
import '../../widgets/reusable/chip_container.dart';

//TODO: Fix Tweets View as it doesnt work ofter compiling a web release.
class SocialTab extends StatefulWidget {
  const SocialTab({super.key});

  @override
  State<SocialTab> createState() => _SocialTabState();
}

class _SocialTabState extends State<SocialTab> {
  @override
  Widget build(BuildContext context) {
    //if you intend to switch twitter user, just configure the 'twitter.html' file.
    // .web/twitter.html

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'twitter',
      (int uid) => IFrameElement()
        ..src = "web/twitter.html"
        ..width = '640'
        ..height = '360'
        ..style.border = "none",
    );
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth < 600) {
              return Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                  _socialbody(),
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                ],
              );
            } else {
              return Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  _socialbody(),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  _socialbody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          _topText(),
          const SizedBox(height: 20),
          _twitterView(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          const Footer()
        ],
      ),
    );
  }

  _topText() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Twitter",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const SizedBox(width: 4),
              const Flexible(
                child: ChipContainer(
                  text: "Beta",
                  color: Color(0xff1DA1F2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Not really a prominent 'TWITTER' user, but wanted a special place where my tweets could easily be displayed, to all interested folks.\nThis page is achieved through use of flutter's html libary to render the html directly into the webApp.",
              textAlign: TextAlign.start,
              style: GoogleFonts.nunitoSans(
                color: Colors.white38,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _twitterView() {
    return Column(children: const [
      SizedBox(
        width: 640,
        height: 360,
        child: HtmlElementView(
          viewType: 'twitter',
        ),
      ),
    ]);
  }
}
