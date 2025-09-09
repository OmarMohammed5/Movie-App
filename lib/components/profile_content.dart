import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviee_app/components/auth_favorite_dialog.dart';
import 'package:moviee_app/components/image_profile.dart';
import 'package:moviee_app/components/logout_button.dart';
import 'package:moviee_app/components/name_and_email_profile.dart';
import 'package:moviee_app/components/profile_menu.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/bottom_nav_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/profile_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/theme_cubit.dart';
import 'package:moviee_app/screens/about_app_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  // logic function for upload image

  XFile? selectedImage;

  /// upload image
  Future<void> _uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showDialog(context: context, builder: (context) => AuthFavoriteDialog());
      return;
    }

    /// if user have an account
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    final isUpload = selectedImage == null;

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            isUpload
                ? " Image Uploaded Successfully"
                : "Image Changed Successfully",
            color: Colors.white,
          ),
          backgroundColor: Colors.grey.shade800,
        ),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_${user.uid}', pickedImage.path);
    }
  }

  /// Saved Image with SharedPreferences
  Future<void> _savedImage() async {
    final user = FirebaseAuth.instance.currentUser;
    final prefs = await SharedPreferences.getInstance();

    if (user == null) {
      setState(() {
        selectedImage = null;
      });
      return;
    }

    final path = prefs.getString('profile_image_${user.uid}');
    setState(() {
      selectedImage = path != null ? XFile(path) : null;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadUserProfile();
    _savedImage();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark;
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(20),

          // Image profile
          Stack(
            children: [
              /// image
              ImageProfile(selectedImage: selectedImage),

              /// upload or change
              Positioned(
                bottom: screenHight * 0.01,
                right: screenWidth * 0.31,
                child: GestureDetector(
                  onTap: _uploadImage,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.kLogoColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      selectedImage == null
                          ? CupertinoIcons.photo
                          : Icons.edit_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Gap(80),

          //// Name && Email
          NameAndEmailProfile(),
          Gap(10),

          // Profile Menu Section
          ProfileMenu(
            icon: isDarkMode
                ? HugeIcons.strokeRoundedSun02
                : HugeIcons.strokeRoundedMoon02,
            title: isDarkMode ? "Light Mode" : "Dark Mode",
            onTap: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          ProfileMenu(
            icon: HugeIcons.strokeRoundedInformationCircle,
            title: "About App",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AboutAppScreen();
                  },
                ),
              );
            },
          ),
          //// Log out Button
          LogoutButton(),
        ],
      ),
    );
  }
}
