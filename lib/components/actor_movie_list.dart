import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/actor_movies_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class ActorMovieList extends StatelessWidget {
  const ActorMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActorMoviesCubit, ActorMoviesState>(
      builder: (context, state) {
        if (state is ActorMoviesLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.kLogoColor,
              strokeWidth: 2,
            ),
          );
        } else if (state is ActorMoviesLoaded) {
          return SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.movies.length,
              separatorBuilder: (context, index) => const Gap(30),
              itemBuilder: (context, index) {
                final actorMovies = state.movies[index];
                return SizedBox(
                  width: 120,
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //// Poster
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: actorMovies.posterUrl,
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
                      ),

                      /// Name of Movie
                      Text(
                        actorMovies.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      /// Character
                      if (actorMovies.character != null &&
                          actorMovies.character!.isNotEmpty)
                        AppText(
                          actorMovies.character!,
                          maxLines: 1,
                          color: Colors.white70,
                          fontSize: 13,
                        ),

                      /// Year
                      AppText(
                        actorMovies.year,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is ActorMoviesError) {
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
    );
  }
}
