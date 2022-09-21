import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LoadingIndicator(
        indicatorType: Indicator.ballZigZagDeflect,
        colors: [Colors.white, Colors.deepPurple],
      ),
    );
  }
}
