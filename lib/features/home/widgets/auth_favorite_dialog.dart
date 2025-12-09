import 'package:flutter/material.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';
import 'package:moviee_app/features/auth/screen/login_screen.dart';
import 'package:moviee_app/features/auth/screen/signup_screen.dart';

class AuthFavoriteDialog extends StatelessWidget {
  const AuthFavoriteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      title: CustomText(
        "Login Required",
        fontWeight: FontWeight.bold,
        fontSize: 18,
        // color: Colors.white,
      ),
      content: CustomText(
        "Create an account to add favorites.",
        maxLines: 3,
        fontSize: 14,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: CustomText("Cancel", color: AppColors.kLogoColor),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: CustomText("Log in  / "),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupScreen();
                        },
                      ),
                    );
                  },
                  child: CustomText("Sign up"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
