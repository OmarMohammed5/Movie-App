import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviee_app/features/auth/widgets/profile_menu.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/bottom_nav_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ProfileMenu(
      icon: HugeIcons.strokeRoundedLogout02,
      color: AppColors.kLogoColor,
      title: CustomText("Log Out", fontSize: 16, color: AppColors.kLogoColor),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
              title: CustomText(
                "Are you sure you want to log out ?",
                fontSize: 18,
                maxLines: 2,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: CustomText("Cancel"),
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.read<AuthCubit>().logout(context);
                            // Clear Favorites after logout
                            context.read<FavoritesCubit>().clearFavorites();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: CustomText(
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
                          child: CustomText(
                            "Log Out",
                            color: AppColors.kLogoColor,
                          ),
                        );
                      },
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
