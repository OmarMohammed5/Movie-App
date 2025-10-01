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

  bool isPasswordVisible = false;
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey.shade800,
              duration: Duration(seconds: 3),
              content: AppText(
                "Logged in successfully ",
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              /// default of bottom nav bar >> Home Screen
              builder: (context) => BottomNavBar(),
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey.shade800,
              content: AppText(
                state.errorMessage,
                fontSize: 15,
                color: Colors.white,
              ),
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
              //// Headtr
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
                obscureText: !isPasswordVisible,
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 25,
                  ),
                ),
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
                // If you want the toggle functionality, update your TextFieldWidget to accept a Widget for suffixIcon.
              ),

              Gap(40),

              /// Login Button
              if (state is AuthLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kLogoColor,
                    strokeWidth: 2,
                  ),
                )
              else
                AuthButtonWidget(
                  text: 'Log in',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().logIn(
                        email: _email.text,
                        password: _password.text,
                        context: context,
                      );
                    }
                  },
                ),

              Gap(10),
              //// Forget Password
              ForgotPasswordWidget(),
              Gap(60),
              //// if you new >>> Sign up
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
