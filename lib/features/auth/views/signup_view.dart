import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_market_app/features/auth/views/login_view.dart';
import 'package:fruits_market_app/layout.dart';
import 'package:fruits_market_app/shared/custom_Auth_button.dart';
import 'package:gap/gap.dart' show Gap;

import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textFeild.dart';

class SignupView extends StatelessWidget {
   SignupView({super.key});

   final GlobalKey<FormState> formKey= GlobalKey<FormState>();

  TextEditingController emailController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController passController= TextEditingController();
  TextEditingController confirmPassController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(180),
                SvgPicture.asset("assets/images/logo1.svg",color: AppColors.primary,),
                CustomText(text: "Welcome to our Food App"),
                Gap(120),
               Expanded(
                 child: Container(
                   padding: EdgeInsets.all(20),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.only(
                         topRight: Radius.circular(30),
                         topLeft: Radius.circular(30),

                     ),
                     color: AppColors.primary,
                     
                   ),
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         Gap(30),
                         CustomTextfeild(
                             controller: nameController,
                             hint: "Name",
                             isPassword: false),
                         Gap(15),
                         CustomTextfeild(

                             controller: emailController,
                             hint: "Email Address",
                             isPassword: false),
                         Gap(15),
                         CustomTextfeild(
                             controller: passController,
                             hint: "Password",
                             isPassword: true),
                         Gap(30),
                         CustomAuthButton(
                             textColor: Colors.white,
                             color: AppColors.primary,
                             onTap: (){
                               Navigator.push(context,
                                   MaterialPageRoute(builder:(c){
                                     return Layout();
                                   }));

                               // if(formKey.currentState!.validate()){
                               //   print("Success Register");
                               // }
                             },
                             text: "Sign Up"),
                         Gap(10),
                         CustomAuthButton(
                           textColor: AppColors.primary,
                           color: Colors.white,
                             onTap: (){
                               Navigator.push(context,
                                   MaterialPageRoute(builder:(c){
                                     return LoginView();
                                   }));
                               // if(formKey.currentState!.validate()){
                               //   print("Success Register");
                               // }
                             },
                             text: "Go To Login ? "),
                        Gap(150),
                       ],
                     ),
                   ),
                 ),
               )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
