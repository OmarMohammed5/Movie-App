import 'package:flutter/material.dart';
import 'package:moviee_app/features/favorite/widgets/favorite_app-bar.dart';
import 'package:moviee_app/features/favorite/widgets/favorite_body_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key, this.moviee});

  final dynamic moviee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// app bar
      appBar: FavoriteAppBar(),
      //// favorite movie
      body: FavoriteBodyWidget(),
    );
  }
}
