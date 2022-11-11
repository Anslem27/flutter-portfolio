// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/theme/colors.dart';
import 'package:flutter_portfolio/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;
import '../../services/reddit_service.dart';
import '../../utils/footer.dart';
import '../../widgets/loader.dart';
import '../../widgets/reusable/chip_container.dart';
import 'package:flip_card/flip_card.dart';

class WebAboutPage extends StatefulWidget {
  const WebAboutPage({super.key});

  @override
  State<WebAboutPage> createState() => _WebAboutPageState();
}

class _WebAboutPageState extends State<WebAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth < 600) {
                  return Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                      //dasboard column
                      _aboutbody(),
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width / 5),
                      //about column
                      _aboutbody(),
                      SizedBox(width: MediaQuery.of(context).size.width / 5),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _aboutbody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          _topText(),
          const SizedBox(height: 30),
          _topImage(),
          const SizedBox(height: 20),
          _bio(),
          const SizedBox(height: 20),
          const Footer()
        ],
      ),
    );
  }

  _topText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
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
                      "About Me",
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Flexible(
                      child: ChipContainer(
                        text: "Tap Image for Easter Egg",
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _bio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Bio",
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 5),
          child: RichText(
            text: TextSpan(
              text: 'Anslem Seguya ',
              style: GoogleFonts.ubuntu(
                color: Colors.white38,
                fontSize: 22,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'is a self taught junior developer with a desire for frontend development. ',
                  style: GoogleFonts.roboto(color: Colors.blue, fontSize: 16),
                  // recognizer: TapGestureRecognizer()
                  //   ..onTap = () {
                  //     // navigate to desired screen
                  //   },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 5),
          child: RichText(
            text: TextSpan(
              text:
                  'Anslem Seguya is still a student at Kyamboggo University pursuing a bachelors degree in Information Technology and Computing.',
              style: GoogleFonts.ubuntu(
                color: Colors.white38,
                fontSize: 15,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      '\nWhile programming is my true desire and reason to exist,my ',
                  style:
                      GoogleFonts.ubuntu(color: Colors.white38, fontSize: 15),
                ),
                TextSpan(
                  text: 'family ',
                  style: GoogleFonts.ubuntu(
                      color: Colors.deepPurple, fontSize: 15),
                ),
                TextSpan(
                  text: 'and ',
                  style:
                      GoogleFonts.ubuntu(color: Colors.white38, fontSize: 15),
                ),
                TextSpan(
                  text: 'will to please my creator ',
                  style: GoogleFonts.ubuntu(
                      color: Colors.deepPurple, fontSize: 16),
                ),
                TextSpan(
                  text: 'are the true foundations of my life.',
                  style:
                      GoogleFonts.roboto(color: Colors.white38, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 5),
          child: RichText(
            text: TextSpan(
              text: 'Want to say hi ',
              style: GoogleFonts.roboto(
                color: Colors.white38,
                fontSize: 16,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Email me 👋',
                  style: GoogleFonts.roboto(color: Colors.blue, fontSize: 16),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      js.context
                          .callMethod('open', ['mailto:${Constants.email}']);
                    },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bioConnectItem(
              FontAwesomeIcons.github,
              "Github",
              () {
                js.context.callMethod('open', [Constants.githubLink]);
              },
              Colors.deepPurple,
            ),
            _bioConnectItem(
              FontAwesomeIcons.reddit,
              "Reddit",
              () {
                js.context.callMethod('open', [Constants.reditLink]);
              },
              Colors.orange,
            ),
          ],
        )
      ],
    );
  }

  _bioConnectItem(IconData icon, String text, Function()? onTap, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colors["primary"],
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          splashColor: Colors.deepPurple,
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: GoogleFonts.roboto(fontSize: 19, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  _topImage() {
    return LayoutBuilder(builder: (_, constraints) {
      return FlipCard(
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          front: GlassmorphicContainer(
            padding: const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height / 1.3,
            width: constraints.maxWidth < 600
                ? double.maxFinite
                : MediaQuery.of(context).size.width * 0.48,
            borderRadius: 8,
            blur: 20,
            border: 5,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.1),
                  const Color(0xFFFFFFFF).withOpacity(0.05),
                ],
                stops: const [
                  0.1,
                  1
                ]),
            borderGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff7fffd4), Colors.blue, Colors.purple],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: const AssetImage("assets/images/1.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
          ),
          back: FutureBuilder(
              future: fetchRedditInfo(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  var avatarImage = snapshot.data!.snoovatarImg;

                  return GlassmorphicContainer(
                    padding: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: constraints.maxWidth < 600
                        ? double.maxFinite
                        : MediaQuery.of(context).size.width * 0.48,
                    borderRadius: 8,
                    blur: 20,
                    border: 5,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1
                        ]),
                    borderGradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xff7fffd4), Colors.blue, Colors.purple],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(avatarImage as String),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(height: 25, child: Loader());
                }
              }));
    });
  }
}
