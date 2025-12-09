import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/core/cubit/cubit/cast_cubit.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';
import 'package:moviee_app/features/actor%20profile/screen/actor_profile_screen.dart';

class MovieCastSection extends StatefulWidget {
  const MovieCastSection({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieCastSection> createState() => _MovieCastSectionState();
}

class _MovieCastSectionState extends State<MovieCastSection> {
  @override
  void initState() {
    super.initState();
    context.read<CastCubit>().getCastMovies(widget.movieId);
  }

  String _getFirstTwoWords(String text) {
    final parts = text.split(" ");
    if (parts.length <= 2) return text;
    return "${parts[0]} ${parts[1]}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //// Casts
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText("Casts", fontSize: 18, fontWeight: FontWeight.w700),
            ],
          ),
        ),

        const Gap(20),

        //// List of Actors
        BlocBuilder<CastCubit, CastState>(
          builder: (context, state) {
            if (state is CastLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.kLogoColor,
                  strokeWidth: 2,
                ),
              );
            } else if (state is CastLoaded) {
              return SizedBox(
                height: 160,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.castModel.length,
                  separatorBuilder: (context, index) => const Gap(20),
                  itemBuilder: (context, index) {
                    final actor = state.castModel[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ActorProfileScreen(actorId: actor.id);
                            },
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            ///  Image of Actor
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: actor.profilePath ?? "",
                                fit: BoxFit.cover,
                                width: 90,
                                height: 90,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kLogoColor,
                                    strokeWidth: 2,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),

                            const Gap(8),

                            ///  Name of Actor
                            CustomText(
                              _getFirstTwoWords(actor.name),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),

                            /// Character
                            CustomText(
                              _getFirstTwoWords(actor.character),
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is CastError) {
              return Center(
                child: CustomText(
                  state.errorMessage,
                  color: AppColors.kLogoColor,
                  fontSize: 16,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
