import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:moviee_app/features/home/widgets/auth_favorite_dialog.dart';
import 'package:moviee_app/features/movie/widgets/movie_details_body.dart';
import 'package:moviee_app/features/movie/widgets/movie_poster_app_bar.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/core/constant/app_colors.dart';

class DetailsMovieScreen extends StatefulWidget {
  const DetailsMovieScreen({super.key, required this.movieId});
  final int movieId;

  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().getDetailsMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    /// to build details screen
    // context.read<MovieDetailsCubit>().getDetailsMovie(widget.movieId);

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
            builder: (context, state) {
              if (state is MovieDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kLogoColor,
                    strokeWidth: 2,
                  ),
                );
              } else if (state is MovieDetailsLoaded) {
                final movie = state.movie;

                return CustomScrollView(
                  slivers: [
                    ///  Top Poster with AppBar
                    MoviePosterAppBar(screenHeight: screenHeight, movie: movie),

                    /// Movie Details Body
                    MovieDetailsBody(movie: movie),
                  ],
                );
              } else if (state is MovieDetailsError) {
                return Center(
                  child: Lottie.asset(
                    "assets/spider 404.json",
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),

          // /// Fixed App Bar Buttons (back & favorite)
          Positioned(
            top: screenHeight * 0.052,
            left: 12,
            right: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft01,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                  builder: (context, state) {
                    if (state is MovieDetailsLoaded) {
                      final movie = state.movie;

                      return BlocSelector<FavoritesCubit, FavoritesState, bool>(
                        selector: (favState) {
                          if (favState is FavoritesLoaded) {
                            return favState.favorites.any(
                              (fav) =>
                                  fav['id'].toString() == movie.id.toString(),
                            );
                          }
                          return false;
                        },
                        builder: (context, isFav) {
                          return IconButton(
                            onPressed: () {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user == null) {
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
                                });
                              }
                            },
                            icon: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.7),
                              ),
                              child: Icon(
                                CupertinoIcons.heart_solid,
                                color: isFav
                                    ? AppColors.kLogoColor
                                    : Colors.white,
                                size: 25,
                              ),
                            ),
                          );
                        },
                      );
                    }

                    /// If not exist data
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
