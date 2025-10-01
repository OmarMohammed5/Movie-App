import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviee_app/models/movie_model.dart';
import 'package:moviee_app/theme/app_colors.dart';

class MoviePosterAppBar extends StatelessWidget {
  const MoviePosterAppBar({
    super.key,
    required this.screenHeight,
    required this.movie,
  });

  final double screenHeight;
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      expandedHeight: screenHeight * 0.63,
      pinned: true,
      backgroundColor: Colors.black.withValues(alpha: 0.0),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            /// Poster
            CachedNetworkImage(
              imageUrl: movie.poster,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.kLogoColor,
                  strokeWidth: 2,
                ),
              ),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error, color: AppColors.kLogoColor)),
            ),

            /// Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
