import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moviee_app/components/expand_able_text.dart';
import 'package:moviee_app/models/actor_model.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class ActorDetails extends StatelessWidget {
  const ActorDetails({super.key, required this.actorModel});

  final ActorModel actorModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// name of actor
        AppText(
          actorModel.name,
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        const Gap(8),

        AppText(
          actorModel.knownForDepartment,
          color: Colors.grey.shade300,
          fontSize: 16,
        ),

        const Gap(25),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Birthday
              Row(
                spacing: 8,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedBirthdayCake,
                    color: Colors.grey,
                    size: 22,
                  ),
                  AppText(
                    "Born  :  ${actorModel.birthday}",
                    color: Colors.grey.shade300,
                    fontSize: 14,
                  ),
                ],
              ),
              Gap(8),
              //// Place of birthday
              Row(
                spacing: 6,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedGoogleMaps,
                    color: Colors.grey,
                    size: 22,
                  ),
                  AppText(
                    "Place  :   ${actorModel.placeOfBirth}",
                    color: Colors.grey.shade300,
                    fontSize: 14,
                  ),
                ],
              ),
              Gap(8),
              Row(
                spacing: 8,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedCalendar03,
                    color: Colors.grey,
                    size: 22,
                  ),
                  AppText(
                    "Died  :   ${actorModel.deathday}",
                    color: Colors.grey.shade300,
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ),

        const Gap(30),

        /// ===== About Section =====
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [AppText("Biography", color: Colors.white, fontSize: 18)],
          ),
        ),

        ///  Read more
        Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ExpandableText(
            text: actorModel.biography,
            trimLines: 4,
            textStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            linkStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
      ],
    );
  }
}
