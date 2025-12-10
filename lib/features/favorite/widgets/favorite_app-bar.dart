import 'package:flutter/material.dart';
import 'package:moviee_app/shared/custom_text.dart';

class FavoriteAppBar extends StatelessWidget implements PreferredSize {
  const FavoriteAppBar({super.key});
  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      shadowColor: Colors.black26,
      centerTitle: true,
      title: CustomText(
        "My Favorites",
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
