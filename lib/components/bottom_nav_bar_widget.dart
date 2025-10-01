import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/core/cubit/cubit/bottom_nav_cubit.dart';
import 'package:moviee_app/screens/favourite_screen.dart';
import 'package:moviee_app/screens/home_screen.dart';
import 'package:moviee_app/screens/profile_screen.dart';
import 'package:moviee_app/screens/search_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
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
          padding: EdgeInsets.all(7),
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: [
            /// Home
            PersistentBottomNavBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome03,
                  color: Colors.red,
                ),
              ),
              inactiveIcon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome03,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              title: "Home",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
            ),

            /// Search
            PersistentBottomNavBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  color: Colors.red,
                ),
              ),
              inactiveIcon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              title: "Search",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
            ),

            /// Favorite
            PersistentBottomNavBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedFavourite,
                  color: Colors.red,
                ),
              ),
              inactiveIcon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedFavourite,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              title: "Favorite",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
            ),

            /// Profile
            PersistentBottomNavBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: Colors.red,
                ),
              ),
              inactiveIcon: Padding(
                padding: const EdgeInsets.only(top: 4),

                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              title: "Profile",
              textStyle: TextStyle(
                fontFamily: GoogleFonts.acme().fontFamily,
                fontSize: 14,
              ),
              activeColorPrimary: Colors.red,
              inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
            ),
          ],

          backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
          navBarHeight: kBottomNavigationBarHeight + 8,
          navBarStyle: NavBarStyle.style6,
          confineToSafeArea: true,
          hideNavigationBarWhenKeyboardAppears: true,
          stateManagement: true,
          resizeToAvoidBottomInset: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            colorBehindNavBar: isDark ? AppColors.kPrimaryColor : Colors.white,
          ),
        );
      },
    );
  }
}
