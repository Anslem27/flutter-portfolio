import 'package:flutter/material.dart';

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
        style: TextStyle(color: color),
      ),
    );
  }
}
