import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ShotCard extends StatelessWidget {
  final String image;
  const ShotCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(8),
      height: boxSize - 20,
      width: boxSize - 40,
      borderRadius: 8,
      blur: 20,
      border: 2,
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
        colors: [
          Color(0xff7fffd4),
          Colors.blue,
          Colors.purple,
        ],
      ),
      child: Container(
       
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
