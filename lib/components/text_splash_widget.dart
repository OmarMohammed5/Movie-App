import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSplashWidget extends StatelessWidget {
  const TextSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 15,
        children: [
          Text(
            "Movie",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.acme().fontFamily,
            ),
          ),
          Text(
            "saga",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.acme().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
