// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:moviee_app/core/cubit/cubit/bottom_nav_cubit.dart';
// import 'package:moviee_app/features/favorite/screen/favourite_screen.dart';
// import 'package:moviee_app/features/home/screen/home_screen.dart';
// import 'package:moviee_app/features/auth/screen/profile_screen.dart';
// import 'package:moviee_app/features/search/screen/search_screen.dart';
// import 'package:moviee_app/core/constant/app_colors.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// class Root extends StatefulWidget {
//   const Root({super.key});

//   @override
//   State<Root> createState() => _RootState();
// }

// class _RootState extends State<Root> {
//   late PersistentTabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 0);
//   }

//   List<Widget> _buildScreens() {
//     return [HomeScreen(), SearchScreen(), FavouriteScreen(), ProfileScreen()];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocBuilder<BottomNavCubit, int>(
//       builder: (context, state) {
//         return PersistentTabView(
//           padding: EdgeInsets.all(7),
//           context,
//           controller: _controller,
//           screens: _buildScreens(),
//           items: [
//             /// Home
//             PersistentBottomNavBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedHome03,
//                   color: Colors.red,
//                 ),
//               ),
//               inactiveIcon: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedHome03,
//                   color: isDark ? Colors.white70 : Colors.black54,
//                 ),
//               ),
//               title: "Home",
//               textStyle: TextStyle(
//                 fontFamily: GoogleFonts.acme().fontFamily,
//                 fontSize: 14,
//               ),
//               activeColorPrimary: Colors.red,
//               inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
//             ),

//             /// Search
//             PersistentBottomNavBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedSearch01,
//                   color: Colors.red,
//                 ),
//               ),
//               inactiveIcon: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedSearch01,
//                   color: isDark ? Colors.white70 : Colors.black54,
//                 ),
//               ),
//               title: "Search",
//               textStyle: TextStyle(
//                 fontFamily: GoogleFonts.acme().fontFamily,
//                 fontSize: 14,
//               ),
//               activeColorPrimary: Colors.red,
//               inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
//             ),

//             /// Favorite
//             PersistentBottomNavBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedFavourite,
//                   color: Colors.red,
//                 ),
//               ),
//               inactiveIcon: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedFavourite,
//                   color: isDark ? Colors.white70 : Colors.black54,
//                 ),
//               ),
//               title: "Favorite",
//               textStyle: TextStyle(
//                 fontFamily: GoogleFonts.acme().fontFamily,
//                 fontSize: 14,
//               ),
//               activeColorPrimary: Colors.red,
//               inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
//             ),

//             /// Profile
//             PersistentBottomNavBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedUser,
//                   color: Colors.red,
//                 ),
//               ),
//               inactiveIcon: Padding(
//                 padding: const EdgeInsets.only(top: 4),

//                 child: HugeIcon(
//                   icon: HugeIcons.strokeRoundedUser,
//                   color: isDark ? Colors.white70 : Colors.black54,
//                 ),
//               ),
//               title: "Profile",
//               textStyle: TextStyle(
//                 fontFamily: GoogleFonts.acme().fontFamily,
//                 fontSize: 14,
//               ),
//               activeColorPrimary: Colors.red,
//               inactiveColorPrimary: isDark ? Colors.white70 : Colors.black54,
//             ),
//           ],

//           backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
//           navBarHeight: kBottomNavigationBarHeight + 8,
//           navBarStyle: NavBarStyle.style6,
//           confineToSafeArea: true,
//           hideNavigationBarWhenKeyboardAppears: true,
//           stateManagement: true,
//           resizeToAvoidBottomInset: true,
//           decoration: NavBarDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40),
//               topRight: Radius.circular(40),
//             ),
//             colorBehindNavBar: isDark ? AppColors.kPrimaryColor : Colors.white,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/features/auth/screen/profile_screen.dart';
import 'package:moviee_app/features/favorite/screen/favourite_screen.dart';
import 'package:moviee_app/features/home/screen/home_screen.dart';
import 'package:moviee_app/features/search/screen/search_screen.dart';
import 'package:moviee_app/shared/glass_nav_bar.dart';

class Root extends StatefulWidget {
  Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late PageController controller;
  late List<Widget> screens;
  int currentScreen = 0;

  late List<AnimationController> iconControllers;

  @override
  void initState() {
    super.initState();

    screens = [
      HomeScreen(),
      SearchScreen(),
      FavouriteScreen(),
      ProfileScreen(),
    ];

    controller = PageController(initialPage: 0);
    iconControllers = List.generate(
      4,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );
    iconControllers[currentScreen].forward();
  }

  @override
  void dispose() {
    controller.dispose();
    for (var c in iconControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => currentScreen = index);
    controller.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutExpo,
    );

    // Animate selected icon
    iconControllers[index].forward();

    // Reverse others
    for (var i = 0; i < iconControllers.length; i++) {
      if (i != index) iconControllers[i].reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // to not return the last screen
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: GlassBottomNavBar(
          currentIndex: currentScreen,
          onTap: _onTabTapped,
          items: [
            BottomNavItemData(
              label: 'Home',
              icon: Icon(CupertinoIcons.home),
              filledIcon: AnimatedIcon(
                icon: AnimatedIcons.menu_home,
                progress: iconControllers[0],
              ),
            ),
            BottomNavItemData(
              label: 'Search',
              icon: Icon(CupertinoIcons.search),
              filledIcon: AnimatedIcon(
                icon: AnimatedIcons.search_ellipsis,
                progress: iconControllers[0],
              ),
            ),
            BottomNavItemData(
              label: 'Favorite',
              icon: Icon(Icons.favorite_border),
              filledIcon: Icon(Icons.favorite),
            ),
            BottomNavItemData(
              label: 'Profile',
              icon: Icon(CupertinoIcons.person_alt_circle),
              filledIcon: Icon(HugeIcons.strokeRoundedProfile),
            ),
          ],
        ),
      ),
    );
  }
}
