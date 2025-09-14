import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviee_app/components/movie_details_body.dart';
import 'package:moviee_app/components/movie_poster_app_bar.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

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
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
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
    );
  }
}
