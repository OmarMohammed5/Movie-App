import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviee_app/screens/login_screen.dart';
import 'package:moviee_app/screens/signup_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class AuthRequiredDialog extends StatelessWidget {
  const AuthRequiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      title: Text(
        "Authentication Required",
        style: TextStyle(fontFamily: GoogleFonts.acme().fontFamily),
      ),
      content: Text(
        "You need to log in / sign up to access the Profile section.",
        style: TextStyle(
          fontFamily: GoogleFonts.acme().fontFamily,
          color: Colors.grey.shade600,
        ),
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
