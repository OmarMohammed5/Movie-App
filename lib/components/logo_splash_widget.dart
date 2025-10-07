import 'package:flutter/material.dart';

class LogoSplashWidget extends StatelessWidget {
  const LogoSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset("assets/images/Movies.png", width: 160),
          ),
        ),
      ],
    );
  }
}
