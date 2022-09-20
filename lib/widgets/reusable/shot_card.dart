import 'package:flutter/material.dart';

class ShotCard extends StatelessWidget {
  final String image;
  const ShotCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    return Container(
      height: boxSize - 30,
      width: boxSize - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
