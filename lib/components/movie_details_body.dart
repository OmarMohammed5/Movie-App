import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/expand_able_text.dart';
import 'package:moviee_app/components/movie_cast_section.dart';
import 'package:moviee_app/components/play_trailer.dart';
import 'package:moviee_app/components/similar_movies_section.dart';
import 'package:moviee_app/models/movie_model.dart';
import 'package:moviee_app/theme/app_text_style.dart';

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
                    AppText(
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
                      AppText(
                        (movie.voteAverage as num).toStringAsFixed(1),
                        fontSize: 16,
                      ),
                    ],
                  ),
                  AppText("||"),
                  AppText(movie.year, fontSize: 16),
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
                        AppText(
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
