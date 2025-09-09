import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviee_app/components/login_form_widget.dart';
import 'package:moviee_app/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenHieght = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,

        body: SingleChildScrollView(
          ///  Form validation
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    /// background
                    SizedBox(
                      height: screenHieght,
                      width: screenWidth,
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kLogoColor,
                                strokeWidth: 2,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  "https://e1.pxfuel.com/desktop-wallpaper/544/126/desktop-wallpaper-related-keywords-suggestions-for-movie-theater-backgrounds-1215x734-for-your-mobile-tablet-movie-screen.jpg",
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      height: screenHieght,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                      ),
                      child:
                          //// Login form [email , password , validation ,  ]
                          LoginFormWidget(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
