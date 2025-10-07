import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:moviee_app/components/auth_button_widget.dart';
import 'package:moviee_app/components/auth_header_section.dart';
import 'package:moviee_app/components/auth_text_row_widget.dart';
import 'package:moviee_app/components/bottom_nav_bar_widget.dart';
import 'package:moviee_app/components/text_field_widget.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({
    super.key,
    required TextEditingController name,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController confirmPassword,
    required GlobalKey<FormState> formkey,
  }) : _name = name,
       _email = email,
       _password = password,
       _confirmPassword = confirmPassword,
       _formkey = formkey;

  final TextEditingController _name;
  final TextEditingController _email;
  final TextEditingController _password;
  final TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formkey;

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(70),
        // Header
        AuthHeaderSection(),
        Gap(30),

        //// Name
        TextFieldWidget(
          controller: widget._name,
          hint: 'Name',
          obscureText: false,
          prefixIcon: CupertinoIcons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Field is Required";
            }
            return null;
          },
        ),
        Gap(15),

        /// Email
        TextFieldWidget(
          controller: widget._email,
          hint: 'Email',
          obscureText: false,
          prefixIcon: Icons.email_outlined,
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
        Gap(15),

        /// Password
        TextFieldWidget(
          maxLength: 6,
          controller: widget._password,
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
        Gap(15),

        //// Confirm Password
        TextFieldWidget(
          maxLength: 6,
          controller: widget._confirmPassword,
          hint: 'Confirm Password',
          obscureText: !isConfirmPasswordVisible,
          prefixIcon: Icons.lock_outline,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isConfirmPasswordVisible = !isConfirmPasswordVisible;
              });
            },
            icon: Icon(
              isConfirmPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 25,
            ),
          ),
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

        Gap(25),

        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.grey.shade800,
                  duration: Duration(seconds: 3),
                  content: AppText(
                    "Account Created Successfully",
                    color: Colors.white,
                  ),
                ),
              );

              /// Navigate to bottom nav bar (home screen)
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => BottomNavBar()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.grey.shade800,
                  content: Text(state.errorMessage),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return CircularProgressIndicator(color: AppColors.kLogoColor);
            }

            /// Sign up Button
            return AuthButtonWidget(
              text: 'Sign up',
              onTap: () {
                if (widget._formkey.currentState!.validate()) {
                  context.read<AuthCubit>().signUp(
                    name: widget._name.text.trim(),
                    email: widget._email.text.trim(),
                    password: widget._password.text.trim(),
                    context: context,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey.shade800,
                      content: AppText(
                        "Please fill all fields correctly",
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),

        Gap(40),

        /// Sign up now
        AuthTextRowWidget(
          title: 'Already on MFlix ?',
          textAuth: 'Log in.',
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
