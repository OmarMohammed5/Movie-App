import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviee_app/components/profile_menu.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/bottom_nav_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return ProfileMenu(
      icon: HugeIcons.strokeRoundedLogout02,
      title: "Log out",
      color: Colors.redAccent,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              backgroundColor: Colors.grey.shade900,
              title: AppText(
                "Are you sure you want to log out ?",
                color: Colors.white,
                fontSize: 18,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: AppText("Cancel", color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<AuthCubit>().logout(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: AppText(
                              "Logout Successfully",
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.grey.shade800,
                          ),
                        );
                        context.read<BottomNavCubit>().changeTab(0);
                        setState(() {
                          selectedImage = null;
                        });
                      },
                      child: AppText("Log Out", color: AppColors.kLogoColor),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
