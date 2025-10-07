import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeaderSection extends StatelessWidget {
  const AuthHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image of App
        Image.asset(
          "assets/images/Movies-removebg-preview.png",
          fit: BoxFit.cover,
          width: 120,
        ),
        Gap(20),
        // title of App
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MFlix",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: GoogleFonts.acme().fontFamily,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
