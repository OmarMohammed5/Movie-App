import 'package:flutter/material.dart';
import 'package:moviee_app/components/favorite_app-bar.dart';
import 'package:moviee_app/components/favorite_body_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key, this.moviee});

  final dynamic moviee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      /// app bar
      appBar: FavoriteAppBar(),
      //// favorite movie
      body: FavoriteBodyWidget(),
    );
  }
}
