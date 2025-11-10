import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_market_app/features/auth/views/signup_view.dart';
import 'package:fruits_market_app/shared/custom_textFeild.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/app_colors.dart';
import '../../../layout.dart';
import '../../../shared/custom_Auth_button.dart';
import '../../../shared/custom_text.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});
final GlobalKey<FormState> formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController= TextEditingController();
    TextEditingController _passwordController= TextEditingController();
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(

        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(180),
                SvgPicture.asset("assets/images/logo1.svg",color: AppColors.primary,),
                Gap(10),
                CustomText(
                  text: 'Welcome Back, Discover The Fast Food',
                  color: Colors.white,
                  size: 13,
                  weight: FontWeight.w500,

                ),
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
                       CustomTextfeild(
                           controller: _emailController,
                           hint: "Email Address",
                           isPassword: false),
                       Gap(15),
                       CustomTextfeild(
                           controller: _passwordController,
                           hint: "Password",
                           isPassword: true),
                       Gap(20),
                       CustomAuthButton(
                           textColor: Colors.white,
                           color: AppColors.primary,
                           onTap:  (){
                             Navigator.push(context,
                                 MaterialPageRoute(builder:(c){
                                   return Layout();
                                 }));

                             // if(formKey.currentState!.validate()){
                             //   print("Success login");
                             // }
                           },
                           text: "Login"),
                       Gap(10),
                       CustomAuthButton(
                           textColor: AppColors.primary,
                           color: Colors.white,
                           onTap: (){
                             Navigator.push(context,
                                 MaterialPageRoute(builder:(c){
                                   return SignupView();
                                 }));
                             // if(formKey.currentState!.validate()){
                             //   print("Success Register");
                             // }
                           },
                           text: "Sign Up ? "),
                       Gap(20),
                           GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(
                                     builder:(c)=>Layout() ));
                               },
                               child:CustomText(text:" Continue as a guest ?",color: Colors.orange,weight: FontWeight.bold,size: 15,)
                           ),

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


