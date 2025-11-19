import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/views/signup_view.dart';
import 'package:hungry_app/shared/custom_textFeild.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/app_colors.dart';
import '../../../layout.dart';
import '../../../shared/custom_Auth_button.dart';
import '../../../shared/custom_snakbar.dart';
import '../../../shared/custom_text.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (c) => Layout()));
        }
        setState(() => isLoading = false);
      } catch (e, s) {
        setState(() => isLoading = false);

        print("❌ Login error: $e");
        print("❌ Stack: $s");

        String errorMsg = "unhandled error in login";

        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(
            customSnack(errorMsg),
        );
      }
    }
  }

void initState(){
    emailController.text = "abdo@gmail.com";
    passwordController.text = "12345678";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
     canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Gap(180),
                      SvgPicture.asset(
                        "assets/images/logo1.svg",
                        color: AppColors.primary,
                      ),
                      Gap(10),
                      CustomText(
                        text: 'Welcome Back, Discover The Fast Food',
                        color: Colors.grey.shade400,
                        size: 14,
                        weight: FontWeight.w500,
                      ),
                      Gap(100),

                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.primary,
                        ),
                        child: Column(
                          children: [
                            CustomTextfeild(
                              controller: emailController,
                              hint: "Email Address",
                              isPassword: false,
                            ),
                            Gap(15),
                            CustomTextfeild(
                              controller: passwordController,
                              hint: "Password",
                              isPassword: true,
                            ),
                            Gap(20),
                            isLoading
                                ? CupertinoActivityIndicator(color: Colors.white)
                                : CustomAuthButton(
                                    textColor: Colors.white,
                                    color: AppColors.primary,
                                    onTap: login,
                                    text: "Login",
                                  ),
                            Gap(20),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomAuthButton(
                                    textColor: AppColors.primary,
                                    color: Colors.white,
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (c) {
                                            return SignupView();
                                          },
                                        ),
                                      );
                                    },
                                    text: "Sign Up",
                                  ),
                                ),
                                const Gap(20),
                                Expanded(
                                  child: CustomAuthButton(
                                    width: 300,
                                    textColor: AppColors.primary,
                                    color: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => const Layout()),
                                      );
                                    },
                                    text: "Guest",
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
