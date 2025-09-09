import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/filter_widget.dart';
import 'package:moviee_app/components/filtered_movies_grid.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/filter_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/search_movie_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
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
                  if (v.isNotEmpty) {
                    context.read<SearchMovieCubit>().getSearchMovie(v);
                  }
                },
                style: TextStyle(color: Colors.white),
                controller: controller,
                cursorColor: Colors.white,
                cursorHeight: 20,
                decoration: InputDecoration(
                  hint: AppText("Search", fontSize: 16, color: Colors.white),
                  prefixIcon: HugeIcon(
                    icon: HugeIcons.strokeRoundedSearch01,
                    color: Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.clear();
                        context.read<SearchMovieCubit>().clearSearchText();
                        context.read<SearchMovieCubit>().setSearchText("");
                        context.read<FilterCubit>().setMovies([]);
                      });
                    },

                    child: controller.text.isNotEmpty
                        ? HugeIcon(
                            icon: HugeIcons.strokeRoundedTextClear,
                            color: Colors.white,
                          )
                        : SizedBox.shrink(),
                  ),
                  filled: true,
                  fillColor: AppColors.kTextFieldColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.kTextFieldColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.kTextFieldColor),
                  ),
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
