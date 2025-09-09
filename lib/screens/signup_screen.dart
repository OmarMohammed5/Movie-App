import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviee_app/components/firebase_exceptions.dart';
import 'package:moviee_app/components/signup_form_widget.dart';
import 'package:moviee_app/screens/home_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  /// Sign up

  Future signUp() async {
    if (_password.text.trim() != _confirmPassword.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText("Password don't match", color: AppColors.kLogoColor),
        ),
      );
      return;
    }
    isLoading = true;
    setState(() {});
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: AppText(
            "Account created successfully  ",
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      handelFirebaseSignupException(e);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,

          content: Text("Unexpected error: ${e.toString()}"),
        ),
      );
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

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
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Stack(
                  children: [
                    /// background image
                    SizedBox(
                      height: screenHieght,
                      width: screenWidth,
                      child: Image.network(
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
                          //// signup form [name , email , password , confPassword , validation , BlocConsumer to rebuild it]
                          SignupFormWidget(
                            name: _name,
                            email: _email,
                            password: _password,
                            confirmPassword: _confirmPassword,
                            formkey: _formkey,
                          ),
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
