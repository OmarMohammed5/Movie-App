import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class FavoriteAppBar extends StatelessWidget implements PreferredSize {
  const FavoriteAppBar({super.key});
  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(
        "My Favorites",
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      backgroundColor: AppColors.kPrimaryColor,
      actions: [
        HugeIcon(icon: HugeIcons.strokeRoundedFavourite, color: Colors.white),
        Gap(10),
      ],
    );
  }
}
