import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:lottie/lottie.dart';
import 'package:moviee_app/features/search/widgets/movie_card.dart';
import 'package:moviee_app/core/cubit/cubit/top_movies_cubit.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class TopTenMovies extends StatelessWidget {
  const TopTenMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: Theme.of(context).brightness == Brightness.dark
                            ? [
                                Colors.white.withValues(alpha: .15),
                                Colors.white.withValues(alpha: 0.05),
                              ]
                            : [
                                Colors.white.withValues(alpha: 0.7),
                                Colors.white.withValues(alpha: 0.4),
                              ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: .25)
                            : Colors.black.withValues(alpha: .1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_fire_department_rounded,
                          color: Colors.redAccent,
                          size: 22,
                        ),
                        const Gap(8),
                        CustomText(
                          "Top Ten Movies",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Gap(20),

          BlocBuilder<TopMoviesCubit, TopMoviesState>(
            builder: (context, state) {
              if (state is TopMoviesLoadging) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kLogoColor,
                    strokeWidth: 2,
                  ),
                );
              } else if (state is TopMoviesLoaded) {
                final movies = state.movies.take(10).toList();
                return SizedBox(
                  height: 250,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Gap(20),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieCard(key: ValueKey(movie.id), movie: movie);
                    },
                  ),
                );
              } else if (state is TopMoviesError) {
                return Center(
                  child: Lottie.asset(
                    "assets/spider 404.json",
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
