import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/features/home/widgets/auth_favorite_dialog.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/features/movie/screen/details_movie_screen.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class MovieCategory extends StatelessWidget {
  const MovieCategory({super.key, this.movie});

  final dynamic movie;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        context.read<MovieDetailsCubit>().getDetailsMovie(movie.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => DetailsMovieScreen(movieId: movie.id),
          ),
        );
      },

      child: Container(
        width: screenWidth,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 25,
              offset: Offset(0, 10),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              /// --- Image ---
              CachedNetworkImage(
                imageUrl: movie.poster,
                width: screenWidth,
                height: 240,
                fit: BoxFit.cover,
                placeholder: (_, __) => Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kLogoColor,
                    strokeWidth: 2,
                  ),
                ),
                errorWidget: (_, __, ___) =>
                    Icon(Icons.error, color: AppColors.kLogoColor),
              ),

              /// --- Gradient Overlay ---
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: .35),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),

              /// --- Favorite Button ---
              Positioned(
                top: 12,
                right: 12,
                child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
                  selector: (state) {
                    if (state is FavoritesLoaded) {
                      return state.favorites.any(
                        (fav) => fav['id'].toString() == movie.id.toString(),
                      );
                    }
                    return false;
                  },
                  builder: (_, isFav) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isFav ? Colors.redAccent : Colors.white,
                          size: 22,
                        ),
                        onPressed: () {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            showDialog(
                              context: context,
                              builder: (_) => AuthFavoriteDialog(),
                            );
                            return;
                          }
                          context.read<FavoritesCubit>().toggleFavorite({
                            'id': movie.id,
                            'title': movie.title,
                            'poster': movie.poster,
                            'vote_average': movie.voteAverage,
                            'release_date': movie.releaseDate,
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              /// --- Movie Info ---
              Positioned(
                left: 12,
                right: 12,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    CustomText(
                      movie.title,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      maxLines: 2,
                    ),

                    Gap(6),

                    Row(
                      children: [
                        /// Rating
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            CustomText(
                              movie.voteAverage.toStringAsFixed(1),
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),

                        Gap(20),

                        /// Year Tag
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomText(
                            movie.year,
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
