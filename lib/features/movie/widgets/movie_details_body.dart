import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/shared/expand_able_text.dart';
import 'package:moviee_app/features/movie/widgets/movie_cast_section.dart';
import 'package:moviee_app/features/movie/widgets/play_trailer.dart';
import 'package:moviee_app/features/movie/widgets/similar_movies_section.dart';
import 'package:moviee_app/core/models/movie_model.dart';
import 'package:moviee_app/shared/custom_text.dart';

class MovieDetailsBody extends StatelessWidget {
  const MovieDetailsBody({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Gap(20),
          // const MovieDetailsSection(),
          Column(
            children: [
              ////  play trailer
              PlayTrailer(movieId: movie.id),

              Gap(25),
              //// Name of Movie
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      movie.title,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Gap(22),

              /// Year + Rate
              Row(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedStar,
                        color: Colors.orangeAccent.shade700,
                        size: 20,
                      ),
                      Gap(4),
                      CustomText(
                        (movie.voteAverage as num).toStringAsFixed(1),
                        fontSize: 16,
                      ),
                    ],
                  ),
                  CustomText("||"),
                  CustomText(movie.year, fontSize: 16),
                ],
              ),

              Gap(5),

              Gap(30),
              //// Story OF Movie
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          "The Story",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    Gap(10),
                    //// overView
                    ExpandableText(
                      text: movie.overview,
                      trimLines: 4,
                      textStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      linkStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(40),

          /// Casts
          MovieCastSection(movieId: movie.id),
          const Gap(30),

          /// Similar Movies
          SimilarMoviesSection(movieId: movie.id),
          const Gap(40),
        ],
      ),
    );
  }
}
