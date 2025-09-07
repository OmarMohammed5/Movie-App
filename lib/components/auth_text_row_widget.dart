import 'package:flutter/material.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class AuthTextRowWidget extends StatelessWidget {
  const AuthTextRowWidget({
    super.key,
    required this.title,
    required this.textAuth,
    this.onTap,
  });

  final String title;
  final String textAuth;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          title,
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: onTap,
          child: AppText(
            textAuth,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.kLogoColor,
          ),
        ),
      ],
    );
  }
}
