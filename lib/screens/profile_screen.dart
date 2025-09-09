import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviee_app/components/profile_content.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/profile_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? selectedImage;

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          _savedImage();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        appBar: AppBar(
          title: AppText(
            "Profile",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          actions: [
            HugeIcon(icon: HugeIcons.strokeRoundedUser, color: Colors.white),
            Gap(10),
          ],
          backgroundColor: AppColors.kPrimaryColor,
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.kLogoColor,
                  strokeWidth: 2,
                ),
              );
            } else if (state is AuthLoaded) {
              return ProfileContent();
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    AppText(
                      "You need to login to view your profile",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
