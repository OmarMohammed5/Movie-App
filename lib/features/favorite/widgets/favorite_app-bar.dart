import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class FavoriteAppBar extends StatelessWidget implements PreferredSize {
  const FavoriteAppBar({super.key});
  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText("My Favorites", fontSize: 22, fontWeight: FontWeight.bold),
        ],
      ),
      actions: [
        Icon(CupertinoIcons.heart, color: AppColors.kLogoColor),
        Gap(10),
      ],
    );
  }
}
