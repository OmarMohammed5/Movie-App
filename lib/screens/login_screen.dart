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
                                "https://as1.ftcdn.net/jpg/02/67/96/22/1000_F_267962289_Y9WDy3b7nC5E7GVjuHEZ4vK2q5NU6k9V.jpg",
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    height: screenHieght,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.72),
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
    );
  }
}
