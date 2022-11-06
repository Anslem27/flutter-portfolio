import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipText extends StatelessWidget {
  final String text;
  final Color color;
  const ChipText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: GoogleFonts.ubuntu(color: color),
      ),
    );
  }
}
