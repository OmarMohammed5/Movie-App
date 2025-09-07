import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/expand_able_text.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class MovieDetailsSection extends StatelessWidget {
  const MovieDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ////  Logo
        GestureDetector(
          onTap: () {
            //// Play Moie
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedPlay,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Gap(20),
        //// Name of Movie
        AppText(
          "Prison Break",
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        Gap(10),

        /// Year + type
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              "2005 . Drama , Action . 12 Eposide ",
              fontSize: 14,
              color: Colors.grey,
            ),
          ],
        ),

        Gap(5),

        /// Rate and review
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedStar,
              color: Colors.orangeAccent,
              size: 20,
            ),
            AppText("4.2 ", fontSize: 14, color: Colors.grey),
          ],
        ),
        Gap(30),
        //// Story OF Movie
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    "The Story",
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              Gap(10),

              ExpandableText(
                text:
                    "Ray Breslin manages an elite team of security specialists trained in the art of breaking people out of the world’s most impenetrable prisons. When his most trusted operative, Shu Ren, is kidnapped and disappears inside the most elaborate prison ever built, Ray must track him down with the help of some of his former friends.",
                trimLines: 4,
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
                linkStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
