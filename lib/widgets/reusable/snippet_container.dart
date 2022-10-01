import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnippetConatiner extends StatelessWidget {
  final String logo, title, description;
  final double height, width;
  final Function()? onTap;
  const SnippetConatiner(
      {super.key,
      required this.logo,
      required this.title,
      required this.description,
      this.onTap,
      this.height = 30,
      this.width = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: onTap,
          splashColor: Colors.purpleAccent,
          child: LayoutBuilder(builder: (_, constraints) {
            return Container(
              width: constraints.maxWidth < 600
                  ? double.maxFinite
                  : MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.2,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      logo,
                      height: height,
                      width: width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
