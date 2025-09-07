import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class MovieInfoSection extends StatelessWidget {
  const MovieInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.4,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "Prison Break",
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            const Gap(20),
            AppText(
              "Adventure, Drama, Crime",
              color: Colors.white,
              fontSize: 14,
            ),
            const Gap(6),
            Row(
              children: [
                Icon(
                  HugeIcons.strokeRoundedStar,
                  color: Colors.orangeAccent.shade400,
                  size: 20,
                ),
                const Gap(6),
                AppText(
                  "9.5 . 2005 . 102 min",
                  color: Colors.white,
                  fontSize: 14,
                ),
              ],
            ),
            const Gap(20),
            AppText(
              "During the eve of the 6th of January, a record-breaking snowstorm sweeps across Spain. In the midst of its chaos, a group of robbers seizes the opportunity to hijack an armoured van. A few meters away is Leo, a finished policeman who has nothing to lose. With the unexpected aid of a young woman, he will try to stop the band from",
              maxLines: 4,
              color: Colors.white,
              fontSize: 14,
            ),
            const Gap(20),
            GestureDetector(
              onTap: () {
                //// play video trieller
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedPlay,
                          color: Colors.white,
                          size: 25,
                        ),
                        const Gap(5),
                        AppText("Watch Now", color: Colors.white, fontSize: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
