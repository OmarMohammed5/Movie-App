import 'package:flutter/material.dart';
import 'package:moviee_app/theme/app_text_style.dart';

// ignore: unused_element
class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;
  const _ProfileStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        AppText(
          value,
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        AppText(title, color: Colors.grey, fontSize: 14),
      ],
    );
  }
}
