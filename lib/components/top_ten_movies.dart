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
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.8),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: AppText(
                  "Top Ten Movies",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
