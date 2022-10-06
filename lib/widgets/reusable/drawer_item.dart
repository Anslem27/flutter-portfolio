import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem extends StatelessWidget {
  final Function()? onTap;
  final String title;
  const DrawerItem({
    Key? key,
    this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: GoogleFonts.roboto(fontSize: 15),
            ),
            onTap: onTap,
          ),
          SizedBox(
            height: 5,
            child: Divider(
              height: 0.5,
              color: Colors.grey.shade800,
            ),
          )
        ],
      ),
    );
  }
}
