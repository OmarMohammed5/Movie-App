import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:moviee_app/components/filter_widget.dart';
import 'package:moviee_app/components/movie_category.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/filter_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/search_movie_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocListener<SearchMovieCubit, SearchMovieState>(
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
                                context.read<SearchMovieCubit>().getSearchMovie(
                                  v,
                                );
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            controller: controller,
                            cursorColor: Colors.white,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              hint: AppText(
                                "Search",
                                fontSize: 16,
                                color: AppColors.kIconColor,
                              ),
                              prefixIcon: HugeIcon(
                                icon: HugeIcons.strokeRoundedSearch01,
                                color: AppColors.kIconColor,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controller.clear();
                                    context
                                        .read<SearchMovieCubit>()
                                        .clearSearchText();
                                    context
                                        .read<SearchMovieCubit>()
                                        .setSearchText("");
                                    context.read<FilterCubit>().setMovies([]);
                                  });
                                },

                                child: controller.text.isNotEmpty
                                    ? HugeIcon(
                                        icon: HugeIcons.strokeRoundedTextClear,
                                        color: AppColors.kIconColor,
                                      )
                                    : SizedBox.shrink(),
                              ),
                              filled: true,
                              fillColor: AppColors.kTextFieldColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.kTextFieldColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.kTextFieldColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Gap(40),
                      //// Filter
                      FilterWidget(),

                      //// reBuild ui of search screen
                      BlocBuilder<FilterCubit, FilterState>(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: movies.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                "assets/Search.json",
                                height: 300,
                                width: 300,
                              ),
                            );
                          } else if (state is FilterError) {
                            return Center(child: Text(state.errorMessage));
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
