import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviee_app/models/actor_model.dart';
import 'package:moviee_app/theme/app_colors.dart';

class ActorProfileImage extends StatelessWidget {
  const ActorProfileImage({super.key, required this.actorModel});

  final ActorModel actorModel;
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
            child: CachedNetworkImage(
              imageUrl: actorModel.image!,
              fit: BoxFit.cover,
              width: 130,
              height: 130,
              placeholder: (context, url) => Container(
                width: 130,
                height: 130,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade900,
                ),
                child: CircularProgressIndicator(
                  color: AppColors.kLogoColor,
                  strokeWidth: 2,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 130,
                height: 130,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade800,
                ),
                child: const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
