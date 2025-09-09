import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:moviee_app/components/movie_category.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/filter_cubit.dart';

class FilteredMoviesGrid extends StatelessWidget {
  const FilteredMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state is FilterLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FilterLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Center(
              child: Lottie.asset(
                "assets/Search.json",
                height: 300,
                width: 300,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 20,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCategory(movie: movie);
              },
            ),
          );
        } else if (state is FilterInitial) {
          return Center(
            child: Lottie.asset(
              "assets/Eye Searching.json",
              height: 300,
              width: 300,
            ),
          );
        } else if (state is FilterError) {
          return Center(child: Text(state.errorMessage));
        }
        return SizedBox.shrink();
      },
    );
  }
}
