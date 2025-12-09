import 'package:flutter/material.dart';
import 'package:moviee_app/shared/custom_text.dart';

// ignore: unused_element
class ProfileMenu extends StatelessWidget {
  final IconData icon;
  final CustomText title;
  final void Function()? onTap;
  final Color color;
  const ProfileMenu({
    super.key,
    required this.icon,
    required this.title,
    this.color = Colors.white,
    // ignore: unused_element_parameter
    // ignore: unused_element_parameter
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: title,
      onTap: onTap,
    );
  }
}
