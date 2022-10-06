import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile, webview;
  const ResponsiveWidget(
      {super.key, required this.mobile, required this.webview});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        if (boxConstraints.maxWidth < 800) {
          return mobile;
        } else {
          return webview;
        }
      },
    );
  }
}
