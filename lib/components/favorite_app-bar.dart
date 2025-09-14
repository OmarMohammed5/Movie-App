import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
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
      scrolledUnderElevation: 0,
      title: AppText("My Favorites", fontSize: 22, fontWeight: FontWeight.bold),
      actions: [Icon(CupertinoIcons.heart), Gap(10)],
    );
  }
}
