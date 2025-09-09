import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/core/cubit/cubit/profile_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class NameAndEmailProfile extends StatelessWidget {
  const NameAndEmailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.kLogoColor,
              strokeWidth: 2,
            ),
          );
        }
        if (state is ProfileLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 14,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.person, color: Colors.white, size: 25),
                    AppText(
                      "Name   :    ${state.name}",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
                Gap(20),
                Row(
                  spacing: 14,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.email_outlined, color: Colors.white, size: 25),
                    AppText(
                      "Email   :    ${state.email}",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is ProfileError) {
          return Center(
            child: AppText(state.errorMessage, color: AppColors.kLogoColor),
          );
        } else {
          return Center(child: AppText("Erorr"));
        }
      },
    );
  }
}
