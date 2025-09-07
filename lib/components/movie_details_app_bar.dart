import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/auth_required_dialog.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/models/movie_model.dart';
import 'package:moviee_app/theme/app_colors.dart';

class MovieDetailsAppBar extends StatelessWidget {
  const MovieDetailsAppBar({super.key, required this.movie});

  final MovieModel movie;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 45,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.7),
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          BlocSelector<FavoritesCubit, FavoritesState, bool>(
            selector: (favState) {
              if (favState is FavoritesLoaded) {
                return favState.favorites.any(
                  (fav) => fav['id'].toString() == movie.id.toString(),
                );
              }
              return false;
            },
            builder: (context, isFav) {
              return IconButton(
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AuthRequiredDialog();
                      },
                    );
                  } else {
                    context.read<FavoritesCubit>().toggleFavorite({
                      'id': movie.id,
                      'title': movie.title,
                      'poster': movie.poster,
                      'vote_average': movie.voteAverage,
                      'release_date': movie.releaseDate,
                    });
                  }
                },
                icon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.7),
                  ),
                  child: Icon(
                    CupertinoIcons.heart_solid,
                    color: isFav ? AppColors.kLogoColor : Colors.white,
                    size: 25,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
