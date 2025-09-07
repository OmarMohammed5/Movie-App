import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/filter_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Filter Price =>  Hieght to low
              Row(
                spacing: 5,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<FilterCubit>().filterRate();
                    },
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedFilter,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  AppText("Highest to Lowest", fontSize: 12),
                ],
              ),
              Gap(10),
              // Filter Title  => A to Z
              Row(
                spacing: 5,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<FilterCubit>().filterTitle();
                    },
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedFilterVertical,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                  AppText("A-Z", fontSize: 12),
                ],
              ),

              Spacer(),
              //  Clear Filter
              GestureDetector(
                onTap: () {
                  context.read<FilterCubit>().reset();
                },
                child: Container(
                  width: 120,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.kLogoColor),
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedDelete01,
                        color: Colors.red,
                        size: 20.0,
                      ),
                      AppText(
                        "Clear Filter",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kLogoColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
