import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSplashWidget extends StatelessWidget {
  const TextSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.acme().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
