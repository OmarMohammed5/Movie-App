import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/core/cubit/cubit/profile_cubit.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

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
                    Icon(CupertinoIcons.person, size: 25),
                    CustomText(
                      "Name   :    ${state.name}",
                      fontSize: 16,
                      maxLines: 2,
                    ),
                  ],
                ),
                Gap(20),
                Row(
                  spacing: 14,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.email_outlined, size: 25),
                    CustomText("Email   :    ${state.email}", fontSize: 16),
                  ],
                ),
              ],
            ),
          );
        } else if (state is ProfileError) {
          return Center(
            child: CustomText(state.errorMessage, color: AppColors.kLogoColor),
          );
        } else {
          return Center(child: CustomText("Erorr"));
        }
      },
    );
  }
}
