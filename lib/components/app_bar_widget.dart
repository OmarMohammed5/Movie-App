import 'package:flutter/material.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.kPrimaryColor,
      scrolledUnderElevation: 0,
      leadingWidth: 0,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          AppText(
            "Movie",
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

          AppText(
            "saga",
            color: AppColors.kLogoColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
