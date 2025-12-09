import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/features/home/widgets/app_bar_widget.dart';
import 'package:moviee_app/features/home/widgets/carousel_slider_widget.dart';
import 'package:moviee_app/features/home/widgets/categories_list_widget.dart';
import 'package:moviee_app/features/home/widgets/movie_card_widget.dart';
import 'package:moviee_app/features/home/widgets/top_ten_movies.dart';
import 'package:moviee_app/core/models/movie_model.dart';

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
      appBar: AppBarWidget(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: Gap(40)),

          /// Banners
          SliverToBoxAdapter(child: CarouselSliderWidget()),
          SliverToBoxAdapter(child: Gap(30)),

          /// Top 10 Movies
          SliverToBoxAdapter(child: TopTenMovies()),
          SliverToBoxAdapter(child: Gap(40)),

          /// Categories
          SliverToBoxAdapter(child: CategoriesListWidget()),
          SliverToBoxAdapter(child: Gap(30)),

          /// Movie Cards
          SliverToBoxAdapter(child: MovieCardWidget(movie: widget.movieModel)),

          /// Gap
          SliverToBoxAdapter(child: Gap(30)),
        ],
      ),
    );
  }
}
