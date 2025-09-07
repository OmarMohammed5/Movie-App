import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/screens/favourite_screen.dart';
import 'package:moviee_app/screens/home_screen.dart';
import 'package:moviee_app/screens/profile_screen.dart';
import 'package:moviee_app/screens/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), SearchScreen(), FavouriteScreen(), ProfileScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      /// Home
      PersistentBottomNavBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedHome01,
          color: Colors.redAccent,
        ),
        inactiveIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedHome01,
          color: AppColors.kIconColor,
        ),
        title: ("Home"),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
        ),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.white,
      ),

      /// Search
      PersistentBottomNavBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedSearch01,
          color: Colors.redAccent,
        ),
        inactiveIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedSearch01,
          color: AppColors.kIconColor,
        ),
        title: ("Search"),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
        ),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.white,
      ),

      /// Favorite
      PersistentBottomNavBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedFavourite,
          color: Colors.redAccent,
        ),
        inactiveIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedFavourite,
          color: AppColors.kIconColor,
        ),
        title: ("Favorite"),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
        ),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.white,
      ),

      /// Profile
      PersistentBottomNavBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedUser,
          color: Colors.redAccent,
        ),
        inactiveIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedUser,
          color: AppColors.kIconColor,
        ),
        title: ("Profile"),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
        ),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.black87,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(12),
        colorBehindNavBar: Colors.black,
      ),

      navBarStyle: NavBarStyle.style9,
    );
  }
}
