import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/features/movie/screen/details_movie_screen.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class FavoriteBodyWidget extends StatelessWidget {
  const FavoriteBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Check if user = null >> "User not Logged in" in favorite screen
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Center(
        child: CustomText(
          "User not Logged in",
          color: AppColors.kLogoColor,
          fontSize: 18,
        ),
      );
    }
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.kLogoColor),
          );
        } else if (state is FavoritesLoaded) {
          final favorites = state.favorites;

          if (favorites.isEmpty) {
            return Center(child: CustomText("No favorites yet", fontSize: 22));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.favorites.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final movie = state.favorites[index];
              return GestureDetector(
                onTap: () {
                  // print("Movie tapped: ${movie['id']}, ${movie['title']}");
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailsMovieScreen(
                          key: ValueKey(movie['id']),
                          movieId: movie['id'] as int,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: movie["poster"],
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
                      Positioned(
                        right: 10,
                        top: 10,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: GestureDetector(
                            onTap: () {
                              context.read<FavoritesCubit>().removeFavorite(
                                movie['id'].toString(),
                              );
                            },
                            child: Icon(
                              color: AppColors.kLogoColor,
                              CupertinoIcons.heart_solid,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                movie['title'],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              const Gap(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.orangeAccent,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      CustomText(
                                        (movie['vote_average'] as num)
                                            .toStringAsFixed(1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    DateTime.parse(
                                      movie['release_date'],
                                    ).year.toString(),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is FavoritesError) {
          return Center(
            child: CustomText(
              state.errorMessage,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
