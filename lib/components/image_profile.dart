import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviee_app/theme/app_colors.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile({super.key, required this.selectedImage});

  final XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.kLogoColor, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.black,
          child: ClipOval(
            child: selectedImage == null
                ? null
                : Image.file(File(selectedImage!.path)),
          ),
        ),
      ),
    );
  }
}
