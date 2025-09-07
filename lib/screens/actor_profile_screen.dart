import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/components/actor_details.dart';
import 'package:moviee_app/components/actor_movie_list.dart';
import 'package:moviee_app/components/actor_profile_image.dart';
import 'package:moviee_app/core/cubit/cubit/actor_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/actor_movies_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class ActorProfileScreen extends StatefulWidget {
  const ActorProfileScreen({super.key, required this.actorId});
  final int actorId;
  @override
  State<ActorProfileScreen> createState() => _ActorProfileScreenState();
}

class _ActorProfileScreenState extends State<ActorProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ActorCubit>().getActorProfile(widget.actorId);
    context.read<ActorMoviesCubit>().getActorMovieCredits(widget.actorId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: BlocBuilder<ActorCubit, ActorState>(
            builder: (context, state) {
              if (state is ActorLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kLogoColor,
                    strokeWidth: 2,
                  ),
                );
              } else if (state is ActorLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// ===== Header Section =====
                    const Gap(50),
                    //// image profile
                    ActorProfileImage(actorModel: state.actors),

                    const Gap(16),
                    //// Actor Details [name , born , place , died , biography(cv)]
                    ActorDetails(actorModel: state.actors),

                    const Gap(50),

                    /// ===== His Works =====
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          "His Works",
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Gap(16),
                    //// Actor Movie List [His Works]
                    ActorMovieList(),

                    const Gap(80),
                  ],
                );
              } else if (state is ActorError) {
                return Center(
                  child: AppText(
                    state.errorMessage,
                    color: AppColors.kLogoColor,
                    fontSize: 16,
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
