import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviee_app/shared/custom_text.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // elevation: 0,
        // scrolledUnderElevation: 0,
        // leadingWidth: 0,
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        shadowColor: Colors.black26,
        centerTitle: true,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
            Expanded(
              child: Center(
                child: CustomText(
                  "About App",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(30),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(30),
            //// Logo
            Center(
              child: Image.asset(
                "assets/images/Movies-removebg-preview.png",
                fit: BoxFit.cover,
                width: 200,
              ),
            ),

            Gap(20),
            // App Name
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MFlix",
                  style: TextStyle(
                    fontSize: 32,
                    // color: AppColors.kLogoColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.acme().fontFamily,
                  ),
                ),
              ],
            ),

            Gap(30),
            // Short description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const CustomText(
                "Discover movies, watch trailers, and save your favorites in one place.",
                fontSize: 18,
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
                child: CustomText(
                  "This app lets you explore the latest movies, watch their trailers, "
                  "and keep track of the ones you love. With the favorites feature, "
                  "you can easily save movies and revisit them anytime.",
                  fontSize: 18,
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
                  leading: Icon(Icons.developer_mode),
                  title: CustomText("Developer"),
                  subtitle: CustomText("Omar Mohammed"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
