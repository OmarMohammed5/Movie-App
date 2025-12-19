import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:lottie/lottie.dart';
import 'package:moviee_app/features/home/widgets/auth_favorite_dialog.dart';
import 'package:moviee_app/core/api/dio_consumer.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/similar_movies_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/features/movie/screen/details_movie_screen.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

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
        /// Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                "Similar Movies",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),

        const Gap(20),

        BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
          builder: (context, state) {
            if (state is SimilarMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kLogoColor),
              );
            }

            if (state is SimilarMoviesLoaded) {
              return SizedBox(
                height: 240,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const Gap(18),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.similarMovies.length,
                  itemBuilder: (_, index) {
                    final movie = state.similarMovies[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) =>
                                  MovieDetailsCubit(DioConsumer(dio: Dio()))
                                    ..getDetailsMovie(movie.id),
                              child: DetailsMovieScreen(movieId: movie.id),
                            ),
                          ),
                        );
                      },

                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
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
                              /// Poster
                              CachedNetworkImage(
                                imageUrl: movie.poster,
                                width: 160,
                                height: 240,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kLogoColor,
                                  ),
                                ),
                                errorWidget: (_, __, ___) => Icon(
                                  Icons.error,
                                  color: AppColors.kLogoColor,
                                ),
                              ),

                              /// Gradient
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

                              /// Favorite Button
                              Positioned(
                                top: 8,
                                right: 8,
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
                                                movie.id.toString(),
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
                                            color: Colors.black.withValues(
                                              alpha: 0.35,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.favorite,
                                              color: isFav
                                                  ? Colors.redAccent
                                                  : Colors.white,
                                              size: 18,
                                            ),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              final user = FirebaseAuth
                                                  .instance
                                                  .currentUser;

                                              if (user == null) {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      AuthFavoriteDialog(),
                                                );
                                                return;
                                              }

                                              context
                                                  .read<FavoritesCubit>()
                                                  .toggleFavorite({
                                                    'id': movie.id,
                                                    'title': movie.title,
                                                    'poster': movie.poster,
                                                    'vote_average':
                                                        movie.voteAverage,
                                                    'release_date':
                                                        movie.releaseDate,
                                                  });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                              ),

                              /// Movie Info
                              Positioned(
                                left: 10,
                                right: 10,
                                bottom: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      movie.title,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),

                                    const Gap(6),

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
                                            const SizedBox(width: 4),
                                            CustomText(
                                              movie.voteAverage.toStringAsFixed(
                                                1,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),

                                        const SizedBox(width: 12),

                                        /// Year Badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.15,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: CustomText(
                                            movie.year,
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
                  },
                ),
              );
            }

            if (state is SimilarMoviesError) {
              return Center(
                child: Lottie.asset(
                  "assets/spider 404.json",
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
