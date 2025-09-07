import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviee_app/components/auth_required_dialog.dart';
import 'package:moviee_app/components/image_profile.dart';
import 'package:moviee_app/components/name_and_email_profile.dart';
import 'package:moviee_app/components/profile_menu.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/profile_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/theme_cubit.dart';
import 'package:moviee_app/screens/login_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadUserProfile();
  }
  // logic function for upload image

  XFile? selectedImage;
  // Future<void> _uploadImage() async {
  //   final pickedImage = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );

  //   if (pickedImage != null) {
  //     setState(() {
  //       selectedImage = pickedImage;
  //     });
  //   }
  // }

  Future<void> _uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showDialog(context: context, builder: (context) => AuthRequiredDialog());
      return;
    }

    /// if user have an account
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });

      // await uploadImageToServer(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark; // by default

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppText(
          "Profile",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        actions: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedUser,
            color: AppColors.kIconColor,
          ),
          Gap(10),
        ],
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            // Image profile
            ImageProfile(selectedImage: selectedImage),
            Gap(10),
            // upload image
            GestureDetector(
              onTap: _uploadImage,

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 110),
                child: Container(
                  padding: EdgeInsets.all(6),

                  decoration: BoxDecoration(
                    // color: AppColors.kLogoColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      AppText(
                        selectedImage == null ? "Upload Image" : "Change Image",
                        color: AppColors.kLogoColor,
                        fontSize: 14,
                      ),
                      Icon(
                        //// Upload or change photo
                        selectedImage == null
                            ? Icons.add_photo_alternate_outlined
                            : Icons.edit,
                        color: AppColors.kLogoColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Gap(70),

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
              onTap: () {},
            ),
            ProfileMenu(
              icon: HugeIcons.strokeRoundedLogout02,
              title: "Logout",
              color: Colors.redAccent,
              onTap: () {
                context.read<AuthCubit>().logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
