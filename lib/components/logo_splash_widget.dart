import 'package:flutter/material.dart';

class LogoSplashWidget extends StatelessWidget {
  const LogoSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/Movies-removebg-preview.png",
              width: 160,
            ),
          ),
        ),
      ],
    );
  }
}
