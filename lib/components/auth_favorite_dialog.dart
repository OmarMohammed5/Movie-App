import 'package:flutter/material.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';
import 'package:moviee_app/screens/login_screen.dart';
import 'package:moviee_app/screens/signup_screen.dart';

class AuthFavoriteDialog extends StatelessWidget {
  const AuthFavoriteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      title: AppText(
        "Login Required",
        fontWeight: FontWeight.bold,
        fontSize: 18,
        // color: Colors.white,
      ),
      content: AppText(
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
              child: AppText("Cancel", color: AppColors.kLogoColor),
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
                  child: AppText("Log in  / "),
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
                  child: AppText("Sign up"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
