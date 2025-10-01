import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviee_app/theme/app_colors.dart';

class AuthHeaderSection extends StatelessWidget {
  const AuthHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image of App
        Container(
          padding: EdgeInsets.all(12),
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: AppColors.kLogoColor,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "assets/svg/play_circle_outline.svg",
            fit: BoxFit.cover,
          ),
        ),
        Gap(20),
        // title of App
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Movie",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: GoogleFonts.acme().fontFamily,
              ),
            ),
            Text(
              "saga",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.kLogoColor,
                fontFamily: GoogleFonts.acme().fontFamily,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
