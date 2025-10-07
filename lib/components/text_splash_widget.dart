import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviee_app/theme/app_colors.dart';

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
            "MFlix",
            style: TextStyle(
              fontSize: 56,
              color: Color(0xffe52e22),
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.acme().fontFamily,
            ),
          ),
          // Text(
          //   "saga",
          //   style: TextStyle(
          //     fontSize: 50,
          //     fontWeight: FontWeight.bold,
          //     fontFamily: GoogleFonts.acme().fontFamily,
          //     color: AppColors.kLogoColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
