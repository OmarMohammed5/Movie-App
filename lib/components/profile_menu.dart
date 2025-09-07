import 'package:flutter/material.dart';
import 'package:moviee_app/theme/app_text_style.dart';

// ignore: unused_element
class ProfileMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final void Function()? onTap;

  const ProfileMenu({
    required this.icon,
    required this.title,
    // ignore: unused_element_parameter
    this.color = Colors.white,
    // ignore: unused_element_parameter
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: AppText(title, color: color, fontSize: 16),
      onTap: onTap,
    );
  }
}
