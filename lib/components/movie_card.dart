import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/auth_favorite_dialog.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/screens/details_movie_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class MovieCard extends StatelessWidget {
  final dynamic movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MovieDetailsCubit>().getDetailsMovie(movie.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsMovieScreen(movieId: movie.id),
          ),
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Stack(
              children: [
                ///// Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: movie.poster,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kLogoColor,
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Icons.error, color: AppColors.kLogoColor),
                    ),
                  ),
                ),

                //// re build with (BlocSelector)
                Positioned(
                  right: -2,
                  top: -2,
                  child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
                    selector: (favState) {
                      if (favState is FavoritesLoaded) {
                        return favState.favorites.any(
                          (fav) => fav['id'].toString() == movie.id.toString(),
                        );
                      }
                      return false;
                    },
                    builder: (context, isFav) {
                      return IconButton(
                        onPressed: () {
                          final authState = context.read<AuthCubit>().state;

                          if (authState is! AuthLoaded) {
                            showDialog(
                              context: context,
                              builder: (context) => AuthFavoriteDialog(),
                            );
                          } else {
                            context.read<FavoritesCubit>().toggleFavorite({
                              'id': movie.id,
                              'title': movie.title,
                              'poster': movie.poster,
                              'vote_average': movie.voteAverage,
                              'release_date': movie.releaseDate,
                              'uid': authState.uid,
                            });
                          }
                        },
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: isFav ? Colors.red : Colors.white,
                          size: 25.0,
                        ),
                      );
                    },
                  ),
                ),

                //// Title & Rate & Year
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          movie.title,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedStar,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                                Gap(4),
                                AppText(
                                  movie.voteAverage.toStringAsFixed(1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            AppText(
                              DateTime.parse(movie.releaseDate).year.toString(),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
