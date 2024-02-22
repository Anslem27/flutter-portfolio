// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        splashColor: colors["primary"],
        onTap: () {
          js.context.callMethod('open', ["#"]);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "./assets/images/me.jpeg",
                height: 25,
              ),
            ),
            const SizedBox(width: 3),
            Text("Anslem", style: GoogleFonts.poorStory(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
