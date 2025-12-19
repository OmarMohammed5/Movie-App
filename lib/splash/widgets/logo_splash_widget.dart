import 'package:flutter/material.dart';

class LogoSplashWidget extends StatelessWidget {
  const LogoSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withValues(alpha: 0.2),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Image.asset(
        "assets/images/Movies-removebg-preview.png",
        width: 110,
        height: 110,
      ),
    );
  }
}
