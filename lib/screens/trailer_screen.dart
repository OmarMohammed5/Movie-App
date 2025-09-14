import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // bool isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 6,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText("Trailer", fontSize: 22, fontWeight: FontWeight.bold),
            HugeIcon(
              icon: HugeIcons.strokeRoundedYoutube,
              color: AppColors.kLogoColor,
              size: 25,
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            Navigator.pop(context);
          },
        ),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          FullScreenButton(),
        ],
      ),
    );
  }
}
