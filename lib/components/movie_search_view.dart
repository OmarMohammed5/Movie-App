import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/filter_widget.dart';
import 'package:moviee_app/components/filtered_movies_grid.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/filter_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/search_movie_cubit.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class MovieSearchView extends StatefulWidget {
  const MovieSearchView({super.key});

  @override
  State<MovieSearchView> createState() => _MovieSearchViewState();
}

class _MovieSearchViewState extends State<MovieSearchView> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocListener<SearchMovieCubit, SearchMovieState>(
      listener: (context, state) {
        if (state is SearchMovieLoaded) {
          /// When the search filed come with movies , you must storage in Filter
          context.read<FilterCubit>().setMovies(state.movies);
        }
      },
      child: Column(
        children: [
          Gap(100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 55,

              ///// Search Field
              child: TextFormField(
                onChanged: (v) {
                  setState(() {});
                  if (v.isNotEmpty) {
                    context.read<SearchMovieCubit>().getSearchMovie(v);
                  }
                },
                controller: controller,
                cursorColor: isDark ? Colors.white : Colors.black,
                cursorHeight: 20,
                decoration: InputDecoration(
                  hint: AppText(
                    "Search",
                    fontSize: 16,
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: Icon(
                    HugeIcons.strokeRoundedSearch01,
                    color: Colors.grey.shade500,
                  ),
                  suffixIcon:
                      /// Clear Text Button >> only show when the search text field is not empty
                      controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.clear();
                              context
                                  .read<SearchMovieCubit>()
                                  .clearSearchText();
                              context.read<SearchMovieCubit>().setSearchText(
                                "",
                              );
                              context.read<FilterCubit>().setMovies([]);
                            });
                          },
                          child: Icon(
                            HugeIcons.strokeRoundedTextClear,
                            color: Colors.grey.shade500,
                          ),
                        )
                      : null,
                  filled: true,
                ),
              ),
            ),
          ),

          Gap(40),
          //// Filter
          FilterWidget(),

          //// Filtered Movies Grid
          FilteredMoviesGrid(),
        ],
      ),
    );
  }
}
