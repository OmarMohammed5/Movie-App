// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gap/flutter_gap.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:moviee_app/features/home/widgets/auth_favorite_dialog.dart';
// import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
// import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
// import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
// import 'package:moviee_app/features/movie/screen/details_movie_screen.dart';
// import 'package:moviee_app/core/constant/app_colors.dart';
// import 'package:moviee_app/shared/custom_text.dart';

// class MovieCard extends StatelessWidget {
//   final dynamic movie;
//   const MovieCard({super.key, required this.movie});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.read<MovieDetailsCubit>().getDetailsMovie(movie.id);
//         Navigator.of(context, rootNavigator: true).push(
//           MaterialPageRoute(
//             fullscreenDialog: true,
//             builder: (context) => DetailsMovieScreen(movieId: movie.id),
//           ),
//         );
//       },
//       child: Container(
//         width: 160,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 ///// Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: CachedNetworkImage(
//                     imageUrl: movie.poster,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     placeholder: (context, url) => Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.kLogoColor,
//                         strokeWidth: 2,
//                       ),
//                     ),
//                     errorWidget: (context, url, error) => Center(
//                       child: Icon(Icons.error, color: AppColors.kLogoColor),
//                     ),
//                   ),
//                 ),

//                 //// re build with (BlocSelector)
//                 Positioned(
//                   right: -2,
//                   top: -2,
//                   child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
//                     selector: (favState) {
//                       if (favState is FavoritesLoaded) {
//                         return favState.favorites.any(
//                           (fav) => fav['id'].toString() == movie.id.toString(),
//                         );
//                       }
//                       return false;
//                     },
//                     builder: (context, isFav) {
//                       return IconButton(
//                         onPressed: () {
//                           final authState = context.read<AuthCubit>().state;

//                           if (authState is! AuthLoaded) {
//                             showDialog(
//                               context: context,
//                               builder: (context) => AuthFavoriteDialog(),
//                             );
//                           } else {
//                             context.read<FavoritesCubit>().toggleFavorite({
//                               'id': movie.id,
//                               'title': movie.title,
//                               'poster': movie.poster,
//                               'vote_average': movie.voteAverage,
//                               'release_date': movie.releaseDate,
//                               'uid': authState.uid,
//                             });
//                           }
//                         },
//                         icon: Icon(
//                           Icons.favorite_rounded,
//                           color: isFav ? Colors.red : Colors.white,
//                           size: 25.0,
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 //// Title & Rate & Year
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withValues(alpha: 0.8),
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(16),
//                         bottomRight: Radius.circular(16),
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                       ),
//                     ),

//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         CustomText(
//                           movie.title,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         const Gap(8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 HugeIcon(
//                                   icon: HugeIcons.strokeRoundedStar,
//                                   color: Colors.orangeAccent,
//                                   size: 20,
//                                 ),
//                                 Gap(4),
//                                 CustomText(
//                                   movie.voteAverage.toStringAsFixed(1),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             ),
//                             CustomText(
//                               DateTime.parse(movie.releaseDate).year.toString(),
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/features/home/widgets/auth_favorite_dialog.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/features/movie/screen/details_movie_screen.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

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
            fullscreenDialog: true,
            builder: (_) => DetailsMovieScreen(movieId: movie.id),
          ),
        );
      },

      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              /// --- Poster Image ---
              CachedNetworkImage(
                imageUrl: movie.poster,
                width: 160,
                height: 240,
                fit: BoxFit.cover,
                placeholder: (_, __) => Center(
                  child: CircularProgressIndicator(color: AppColors.kLogoColor),
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
                        Colors.black.withValues(alpha: .85),
                      ],
                    ),
                  ),
                ),
              ),

              /// --- Favorite Button ---
              Positioned(
                top: 8,
                right: 8,
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
                      duration: Duration(milliseconds: 200),
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isFav ? Colors.redAccent : Colors.white,
                          size: 18,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          final authState = context.read<AuthCubit>().state;

                          if (authState is! AuthLoaded) {
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
                            'uid': authState.uid,
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              /// --- Movie Info (bottom section) ---
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    CustomText(
                      movie.title,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      maxLines: 10,
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
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            CustomText(
                              movie.voteAverage.toStringAsFixed(1),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ],
                        ),

                        SizedBox(width: 12),

                        /// Year badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomText(
                            DateTime.parse(movie.releaseDate).year.toString(),
                            fontSize: 11,
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
