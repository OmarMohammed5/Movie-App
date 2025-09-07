import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviee_app/theme/app_colors.dart';

class LogoSplashWidget extends StatelessWidget {
  const LogoSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            "assets/svg/Rectangle 28.svg",
            width: 290,
          ),
        ),
        Positioned(
          top: 70,
          left: 20,
          right: 30,
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              color: AppColors.kLogoColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 90,
          left: 20,
          right: 30,

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
