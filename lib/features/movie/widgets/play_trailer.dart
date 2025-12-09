import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/core/cubit/cubit/movie_trailer_cubit.dart';
import 'package:moviee_app/features/trailler/screen/trailer_screen.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class PlayTrailer extends StatelessWidget {
  const PlayTrailer({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieTrailerCubit, MovieTrailerState>(
      listener: (context, trailerState) {
        if (trailerState is MovieTrailerLoaded) {
          if (trailerState.videos.isNotEmpty) {
            final videoKey = trailerState.videos.first.key;
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => TrailerScreen(videoKey: videoKey),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: CustomText("No trailer available", fontSize: 16),
              ),
            );
          }
        } else if (trailerState is MovieTrailerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(trailerState.errorMessage, fontSize: 16),
            ),
          );
        }
      },

      child: GestureDetector(
        onTap: () {
          context.read<MovieTrailerCubit>().fetchTrailer(movieId);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kLogoColor,
            shape: BoxShape.circle,
          ),
          child: const HugeIcon(
            icon: HugeIcons.strokeRoundedPlay,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
