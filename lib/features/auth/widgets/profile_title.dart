import 'package:flutter/material.dart';
import 'package:moviee_app/shared/custom_text.dart';

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
        CustomText(
          value,
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        CustomText(title, color: Colors.grey, fontSize: 14),
      ],
    );
  }
}
