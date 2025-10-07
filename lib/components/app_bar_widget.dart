import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

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
