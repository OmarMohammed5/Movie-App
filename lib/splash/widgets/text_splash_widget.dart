import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSplashWidget extends StatelessWidget {
  const TextSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "MFLIX",
          style: GoogleFonts.montserrat(
            fontSize: 54,
            letterSpacing: 2,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const Gap(8),
        Text(
          "Unlimited Movies Experience",
          style: GoogleFonts.montserrat(
            fontSize: 14.5,
            letterSpacing: 1,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
