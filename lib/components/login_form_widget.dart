import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/components/auth_button_widget.dart';
import 'package:moviee_app/components/auth_header_section.dart';
import 'package:moviee_app/components/auth_text_row_widget.dart';
import 'package:moviee_app/components/bottom_nav_bar_widget.dart';
import 'package:moviee_app/components/forgot_password_widget.dart';
import 'package:moviee_app/components/text_field_widget.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/screens/home_screen.dart';
import 'package:moviee_app/screens/signup_screen.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Log-in
  Future logIn() async {
    isLoading = true;
    setState(() {});

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: AppText("Logged in successfully ", fontSize: 15),
        ),
      );

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => BottomNavBar()));
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'user-not-found') {
        message = "This email is not registered ";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password ";
      } else {
        message = "Login failed ";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: AppText(message, fontSize: 15),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,

          content: AppText("Unexpected error"),
        ),
      );
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          /// if Login success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.black,
              content: AppText("Logged in successfully ", fontSize: 15),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is AuthError) {
          // if there erro
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              content: AppText(state.errorMessage, fontSize: 15),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(160),
              //// image
              AuthHeaderSection(),
              Gap(40),

              /// Email
              TextFieldWidget(
                hint: 'Email',
                obscureText: false,
                prefixIcon: Icons.email_outlined,

                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is Required";
                  }
                  if (!value.endsWith("@gmail.com")) {
                    return "Please Write Email in Write Format";
                  }
                  return null;
                },
              ),
              Gap(10),

              /// Password
              TextFieldWidget(
                maxLength: 6,
                hint: 'Password',
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.visibility_outlined,

                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is Required";
                  }
                  if (value.length < 6) {
                    return "Password must be 6 numbers";
                  }
                  return null;
                },
              ),

              Gap(40),

              //// Login Button
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.kLogoColor,
                      ),
                    )
                  : AuthButtonWidget(
                      text: 'Log in',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().logIn(
                            email: _email.text,
                            password: _password.text,
                            context: context,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: AppText("User not found", fontSize: 15),
                            ),
                          );
                        }
                      },
                    ),

              Gap(10),

              /// Forgot Password
              ForgotPasswordWidget(),

              Gap(60),

              /// Sign up now
              AuthTextRowWidget(
                title: 'New to Movie saga ?',
                textAuth: 'Sign up now.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignupScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
