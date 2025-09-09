import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/components/app_bar_widget.dart';
import 'package:moviee_app/components/carousel_slider_widget.dart';
import 'package:moviee_app/components/categories_list_widget.dart';
import 'package:moviee_app/components/movie_card_widget.dart';
import 'package:moviee_app/components/top_ten_movies.dart';
import 'package:moviee_app/models/movie_model.dart';
import 'package:moviee_app/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.movieModel});

  final MovieModel? movieModel;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: AppColors.kPrimaryColor,
      appBar: AppBarWidget(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: Gap(40)),

          /// Banners
          SliverToBoxAdapter(child: CarouselSliderWidget()),
          SliverToBoxAdapter(child: Gap(50)),

          /// Top 10 Movies
          SliverToBoxAdapter(child: TopTenMovies()),
          SliverToBoxAdapter(child: Gap(40)),

          /// Categories
          SliverToBoxAdapter(child: CategoriesListWidget()),
          SliverToBoxAdapter(child: Gap(30)),

          // /// Filter
          // SliverToBoxAdapter(child: FilterWidget()),
          // SliverToBoxAdapter(child: Gap(30)),

          /// Movie Cards
          SliverToBoxAdapter(child: MovieCardWidget(movie: widget.movieModel)),

          /// Gap
          SliverToBoxAdapter(child: Gap(30)),
        ],
      ),
    );
  }
}
