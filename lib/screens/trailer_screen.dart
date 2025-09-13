import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen({super.key, required this.videoKey});

  final String videoKey;

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: AppColors.kPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        backgroundColor: AppColors.kPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          spacing: 6,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              "Trailer",
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            HugeIcon(
              icon: HugeIcons.strokeRoundedYoutube,
              color: AppColors.kLogoColor,
              size: 25,
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            progressIndicatorColor: AppColors.kLogoColor,
            showVideoProgressIndicator: true,
          ),

          // Gap(12),
          // //// Movie Title & Year & Favorite
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       AppText(
          //         "Movie Title (year)",
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(CupertinoIcons.heart_solid, color: Colors.red),
          //       ),
          //     ],
          //   ),
          // ),

          // Gap(8),
          // //// Type of Movie
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Row(
          //     children: [
          //       Chip(
          //         label: AppText("Type of Movie", fontSize: 14),
          //         backgroundColor: Colors.grey[800],
          //       ),
          //     ],
          //   ),
          // ),

          // Gap(16),
          // ///// Overview
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       AppText(
          //         "Overview.............................",
          //         color: Colors.white70,
          //         fontSize: 14,
          //         maxLines: 7,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
