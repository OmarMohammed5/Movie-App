import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviee_app/features/home/widgets/movie_category.dart';
import 'package:moviee_app/core/cubit/cubit/movie_cubit.dart';
import 'package:moviee_app/core/models/movie_model.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class MovieCardWidget extends StatefulWidget {
  const MovieCardWidget({super.key, this.movie});
  final MovieModel? movie;
  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    if (widget.movie != null) {
      return MovieCategory(
        key: ValueKey(widget.movie!.id),
        movie: widget.movie!,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.kLogoColor,
                strokeWidth: 2,
              ),
            );
          } else if (state is MovieLoaded) {
            return GridView.builder(
              controller: controller,
              itemCount: state.movies.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCategory(key: ValueKey(movie.id), movie: movie);
              },
            );
          } else if (state is MovieError) {
            return Center(
              child: CustomText(
                state.errorMessage,
                color: AppColors.kLogoColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
