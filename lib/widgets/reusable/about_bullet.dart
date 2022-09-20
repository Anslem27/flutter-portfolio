import 'package:flutter/material.dart';

class AboutBullet extends StatelessWidget {
  final String linkTo, userName;
  final Color textColor;
  final Function()? onTap;
  const AboutBullet(
      {super.key,
      required this.linkTo,
      required this.textColor,
      this.onTap,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.5, bottom: 6),
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
            ),
          ),
          const SizedBox(width: 7),
          Text(
            linkTo,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 2),
          InkWell(
            enableFeedback: false,
            onTap: onTap,
            child: Text(
              userName,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
