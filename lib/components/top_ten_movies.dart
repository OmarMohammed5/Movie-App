import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/components/movie_card.dart';
import 'package:moviee_app/core/cubit/cubit/top_movies_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

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
              AppText(
                "Top Ten Movies",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
                  child: AppText(
                    state.errorMessage,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
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
