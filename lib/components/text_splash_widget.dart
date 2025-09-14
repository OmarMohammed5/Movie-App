import 'package:flutter/material.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

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
          AppText("Movie", fontSize: 50, fontWeight: FontWeight.bold),
          AppText(
            "saga",
            color: AppColors.kLogoColor,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
