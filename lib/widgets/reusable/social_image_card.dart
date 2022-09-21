import 'package:flutter/material.dart';

class SocialImageCard extends StatelessWidget {
  final String image;
  const SocialImageCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    return Container(
      height: boxSize - 5,
      width: boxSize - 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
