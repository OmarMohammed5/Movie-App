import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/core/cubit/cubit/bottom_nav_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: [
            /// Home
            PersistentBottomNavBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome03,
                color: Colors.red,
              ),
              inactiveIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome03,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              title: "Home",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black87,
            ),

            /// Search
            PersistentBottomNavBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: Colors.red,
              ),
              inactiveIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              title: "Search",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black87,
            ),

            /// Favorite
            PersistentBottomNavBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedFavourite,
                color: Colors.red,
              ),
              inactiveIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedFavourite,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              title: "Favorite",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black87,
            ),

            /// Profile
            PersistentBottomNavBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: Colors.red,
              ),
              inactiveIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              title: "Profile",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black87,
            ),
          ],

          backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            colorBehindNavBar: isDark ? Colors.black : Colors.white,
          ),
          navBarStyle: NavBarStyle.style9,
        );
      },
    );
  }
}
