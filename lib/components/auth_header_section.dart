import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

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
            AppText(
              "Movie",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            AppText(
              "saga",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.kLogoColor,
            ),
          ],
        ),
      ],
    );
  }
}
