import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/filter_cubit.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

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
                    child: Icon(HugeIcons.strokeRoundedFilter, size: 30.0),
                  ),
                  CustomText("Highest to Lowest", fontSize: 13),
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
                    child: Icon(
                      HugeIcons.strokeRoundedFilterVertical,
                      size: 30.0,
                    ),
                  ),
                  CustomText("A-Z", fontSize: 13),
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
                      CustomText(
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
