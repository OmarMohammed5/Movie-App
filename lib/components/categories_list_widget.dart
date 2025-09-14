import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/core/api/dio_consumer.dart';
import 'package:moviee_app/core/cubit/cubit/geners_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class CategoriesListWidget extends StatefulWidget {
  const CategoriesListWidget({super.key});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  @override
  void initState() {
    super.initState();
    //// display All Movies when you enter app
    context.read<MovieCubit>().getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenersCubit(DioConsumer(dio: Dio()))..fetchGeners(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                AppText(
                  "Categories",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Gap(15),
            BlocConsumer<GenersCubit, GenersState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GenersLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kLogoColor,
                      strokeWidth: 2,
                    ),
                  );
                }
                final List<String> categoriesDynamic = ['All'];
                if (state is GenersLoaded) {
                  categoriesDynamic.addAll(
                    state.geners.map((g) => g.name).toList(),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 20,
                    children: List.generate(categoriesDynamic.length, (index) {
                      final items = categoriesDynamic[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<GenersCubit>().changeSelectedIndex(
                            index,
                          );
                          if (index == 0) {
                            Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kLogoColor,
                                strokeWidth: 2,
                              ),
                            );
                            context.read<MovieCubit>().getAllMovies();
                          } else {
                            final selectedGenre =
                                (state as GenersLoaded).geners[index - 1];

                            context.read<MovieCubit>().getMoviesByCategory(
                              selectedGenre.id,
                            );
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          width: 100,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color:
                                (state is GenersLoaded &&
                                    state.selectedIndex == index)
                                ? AppColors.kLogoColor
                                : Colors.grey.withValues(alpha: 0.6),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: AppText(
                              items,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
