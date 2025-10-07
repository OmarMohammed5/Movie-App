import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/theme/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      leadingWidth: 0,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/Movies-removebg-preview.png", width: 60),
          HugeIcon(
            icon: HugeIcons.strokeRoundedNotification01,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ],
      ),
    );
  }
}
