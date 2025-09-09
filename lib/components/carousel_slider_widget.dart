import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviee_app/core/api/dio_consumer.dart';
import 'package:moviee_app/core/cubit/cubit/banner_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerCubit(DioConsumer(dio: Dio()))..fetchBanners(),
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.kLogoColor,
                strokeWidth: 2,
              ),
            );
          } else if (state is BannerLoaded) {
            return CarouselSlider.builder(
              itemCount: state.banners.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Stack(
                        children: [
                          /// image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: state.banners[itemIndex].banner,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.kLogoColor,
                                  strokeWidth: 2,
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  Icons.error,
                                  color: AppColors.kLogoColor,
                                ),
                              ),
                            ),
                          ),

                          /// Coming Soon
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: AppText(
                                "Coming Soon",
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          //// Title
                          Positioned(
                            bottom: 35,
                            left: 20,
                            right: 20,
                            child: AppText(
                              state.banners[itemIndex].title,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

              options: CarouselOptions(
                height: 222,
                aspectRatio: 2,
                autoPlay: true,
                viewportFraction: 0.9,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                enlargeCenterPage: true,
              ),
            );
          } else if (state is BannerError) {
            return Center(
              child: AppText(
                state.errorMessage,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
