import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:moviee_app/core/api/dio_consumer.dart';
import 'package:moviee_app/core/cubit/cubit/banner_cubit.dart';
import 'package:moviee_app/core/constant/app_colors.dart';
import 'package:moviee_app/shared/custom_text.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
              itemBuilder: (context, index, _) {
                final banner = state.banners[index];
                return Stack(
                  children: [
                    /// --- Background Poster Image ---
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: banner.banner,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kLogoColor,
                            strokeWidth: 2,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: AppColors.kLogoColor),
                      ),
                    ),

                    /// --- Gradient Overlay ---
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: .3),
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// --- Banner Title at bottom ---
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Text(
                        banner.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black.withValues(alpha: 0.7),
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    /// Optional: Trending / Hot label
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: CustomText(
                          "Trending Now",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: screenHeight * 0.28,
                viewportFraction: 0.85,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                scrollPhysics: BouncingScrollPhysics(),
              ),
            );
          } else if (state is BannerError) {
            return Center(
              child: Lottie.asset(
                "assets/spider 404.json",
                width: 250,
                height: 250,
                fit: BoxFit.cover,
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
