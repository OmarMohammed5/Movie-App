import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
            Expanded(child: Center(child: AppText("About App", fontSize: 24))),
            Gap(30),
          ],
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(30),
            //// Logo
            Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.kLogoColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg/play_circle_outline.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Gap(20),
            // App Name
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText(
                  "Movie ",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  "saga ",
                  fontSize: 24,
                  color: AppColors.kLogoColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            Gap(20),
            // Short description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const AppText(
                "Discover movies, watch trailers, and save your favorites in one place.",
                fontSize: 16,
                // color: Colors.grey,
                maxLines: 7,
              ),
            ),
            Gap(30),
            //  description
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: AppText(
                  "This app lets you explore the latest movies, watch their trailers, "
                  "and keep track of the ones you love. With the favorites feature, "
                  "you can easily save movies and revisit them anytime.",
                  fontSize: 16,
                  maxLines: 7,
                ),
              ),
            ),
            Gap(30),
            //  Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: AppText("Version"),
                  subtitle: AppText("1.0.0"),
                ),
                ListTile(
                  leading: Icon(Icons.developer_mode),
                  title: AppText("Developer"),
                  subtitle: AppText("Omar Mohamed"),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: AppText("Contact"),
                  subtitle: AppText("support@movieapp.com"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
