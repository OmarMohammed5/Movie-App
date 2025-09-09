import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/auth_favorite_dialog.dart';
import 'package:moviee_app/core/api/dio_consumer.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/similar_movies_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/screens/details_movie_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class SimilarMoviesSection extends StatefulWidget {
  const SimilarMoviesSection({super.key, required this.movieId});
  final int movieId;

  @override
  State<SimilarMoviesSection> createState() => _SimilarMoviesSectionState();
}

class _SimilarMoviesSectionState extends State<SimilarMoviesSection> {
  @override
  void initState() {
    super.initState();
    context.read<SimilarMoviesCubit>().getSimilarMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //// Similar Movies
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText(
                "Similar Movies",
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        Gap(20),
        BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
          builder: (context, state) {
            if (state is SimilarMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.kLogoColor,
                  strokeWidth: 2,
                ),
              );
            } else if (state is SimilarMoviesLoaded) {
              return SizedBox(
                height: 250,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Gap(20),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.similarMovies.length,
                  itemBuilder: (context, index) {
                    final similarMovies = state.similarMovies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (_) =>
                                  MovieDetailsCubit(DioConsumer(dio: Dio()))
                                    ..getDetailsMovie(similarMovies.id),
                              child: DetailsMovieScreen(
                                movieId: similarMovies.id,
                              ),
                            ),
                          ),
                        );
                      },

                      child: Container(
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              //// Poster
                              CachedNetworkImage(
                                imageUrl: similarMovies.poster,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kLogoColor,
                                    strokeWidth: 2,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                    Icons.error,
                                    color: AppColors.kLogoColor,
                                  ),
                                ),
                              ),

                              Positioned(
                                right: -2,
                                top: -2,

                                ///============================ Firebase with favourite =====================
                                child:
                                    BlocSelector<
                                      FavoritesCubit,
                                      FavoritesState,
                                      bool
                                    >(
                                      selector: (favState) {
                                        if (favState is FavoritesLoaded) {
                                          return favState.favorites.any(
                                            (fav) =>
                                                fav['id'].toString() ==
                                                similarMovies.id.toString(),
                                          );
                                        }
                                        return false;
                                      },
                                      builder: (context, isFav) {
                                        return IconButton(
                                          onPressed: () {
                                            final user = FirebaseAuth
                                                .instance
                                                .currentUser;

                                            if (user == null) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AuthFavoriteDialog();
                                                },
                                              );
                                            } else {
                                              context
                                                  .read<FavoritesCubit>()
                                                  .toggleFavorite({
                                                    'id': similarMovies.id,
                                                    'title':
                                                        similarMovies.title,
                                                    'poster':
                                                        similarMovies.poster,
                                                    'vote_average':
                                                        similarMovies
                                                            .voteAverage,
                                                    'release_date':
                                                        similarMovies
                                                            .releaseDate,
                                                  });
                                            }
                                          },
                                          icon: Icon(
                                            CupertinoIcons.heart_solid,
                                            color: isFav
                                                ? AppColors.kLogoColor
                                                : Colors.white,
                                            size: 25.0,
                                          ),
                                        );
                                      },
                                    ),

                                ///============================ Firebase with favourite =====================
                              ),
                              //// Title && Rate && Year
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.black.withValues(alpha: 0.6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppText(
                                        similarMovies.title,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      const Gap(8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              HugeIcon(
                                                icon:
                                                    HugeIcons.strokeRoundedStar,
                                                color: Colors.orangeAccent,
                                                size: 20,
                                              ),
                                              Gap(4),
                                              AppText(
                                                (similarMovies.voteAverage
                                                        as num)
                                                    .toStringAsFixed(1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          AppText(
                                            similarMovies.year,
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
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is SimilarMoviesError) {
              return Center(
                child: AppText(
                  state.errorMessage,
                  color: AppColors.kLogoColor,
                  fontSize: 16,
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
