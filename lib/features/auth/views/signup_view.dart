import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:hungry_app/layout.dart';
import 'package:hungry_app/shared/custom_Auth_button.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_snakbar.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textFeild.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isLoading = false;

  final AuthRepo authRepo = AuthRepo();

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final user = await authRepo.signup(
        nameController.text.trim(),
        emailController.text.trim(),
        passController.text.trim(),
      );

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const Layout()),
        );
      }

      setState(() => isLoading = false);
    } catch (e, s) {
      setState(() => isLoading = false);
      debugPrint("❌ Signup error: $e");
      debugPrint("❌ Stack: $s");

      String errorMsg = "Unhandled error in Register";
      if (e is ApiError) errorMsg = e.message;

      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(120),
                      // Logo
                      SvgPicture.asset(
                        "assets/images/logo1.svg",
                        color: AppColors.primary,
                      ),

                      const Gap(10),
                      CustomText(
                        text: "Welcome to our Food App",
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const Gap(40),
                      // Form container
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(30),
                          color: AppColors.primary,
                        ),
                        child: Column(
                          children: [
                            const Gap(30),

                            CustomTextfeild(
                              controller: nameController,
                              hint: "Name",
                              isPassword: false,
                            ),
                            const Gap(15),

                            CustomTextfeild(
                              controller: emailController,
                              hint: "Email Address",
                              isPassword: false,
                            ),
                            const Gap(15),

                            CustomTextfeild(
                              controller: passController,
                              hint: "Password",
                              isPassword: true,
                            ),
                            const Gap(30),

                            isLoading
                                ? const CupertinoActivityIndicator(color: Colors.white)
                                : CustomAuthButton(
                              textColor: Colors.white,
                              color: AppColors.primary,
                              onTap: signup,
                              text: "Sign Up",
                            ),

                            const Gap(15),

                            Row(
                              children: [
                                Expanded(
                                  child: CustomAuthButton(
                                    width: 300,
                                    textColor: AppColors.primary,
                                    color: Colors.white,
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => LoginView()),
                                      );
                                    },
                                    text: "Login",
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

                            const Gap(10),
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
