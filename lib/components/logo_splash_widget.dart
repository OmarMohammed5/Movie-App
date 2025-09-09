import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviee_app/theme/app_colors.dart';

class LogoSplashWidget extends StatelessWidget {
  const LogoSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            color: AppColors.kLogoColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/svg/play_circle_outline.svg",
              width: 120,
            ),
          ),
        ),
      ],
    );
  }
}
