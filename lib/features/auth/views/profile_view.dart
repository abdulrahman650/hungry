import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_market_app/core/constant/app_colors.dart';
import 'package:gap/gap.dart' show Gap;

import '../../../shared/custom_text.dart';
import '../widgets/custom_user_txtfield.dart';
import 'login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final TextEditingController  _name = TextEditingController();
  final TextEditingController  _email = TextEditingController();
  final TextEditingController  _address = TextEditingController();
  @override
  void initState() {
    super.initState();
    _name.text = "abdulrahman";
    _email.text= "abulrahman@gmail.com";
    _address.text = "20 Elkhalaa, Samanoud, Garbia";

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor:AppColors.primary,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
            color: Colors.white,
            )),
        actions: [
          GestureDetector(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 12),
                child: SvgPicture.asset("assets/icons/settings.svg",
                width: 20,),
              )),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(16),
              Center(
                child: Container(
                  height: 120,
                width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage("assets/images/profile2.jpg"),
                    fit: BoxFit.cover,
                    ),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 5,color: Colors.white)
                  ),
          
                ),
              ),
              Gap(30),
              CustomUserTxtfield(controller: _name, label: "Name",),
              Gap(20),
              CustomUserTxtfield(controller:_email, label: "Email",),
              Gap(20),
              CustomUserTxtfield(controller: _address, label: "Address",),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(right: 35.0,left: 35.0),
                child: Divider(),
              ),
              Gap(20),
              ListTile(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                leading: Image.asset("assets/icons/profile_visa.png",width: 60,),
                title: CustomText(text: "Debit card",color:Colors.black,),
                subtitle: CustomText(text: "3434 **** **** 4123",color:Colors.grey.shade900,),
                trailing:  CustomText(text: "Default",color:Colors.black,),
              ),
              Gap(300),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Container(
          height: 80,
          decoration: BoxDecoration(

          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                  decoration: BoxDecoration(

                      border: Border.all(width: 3,color:AppColors.primary,),
                      borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [CustomText(text: "Edit Profile",size: 18,weight: FontWeight.w500,color: AppColors.primary,),
                    Gap(3),
                    Image.asset("assets/icons/edit.png",width: 20,height: 20,)
                    ],
                  ),
                ),
              ),
              Gap(10),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(c){
                          return LoginView();
                        }));
                  }, child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [CustomText(text: "Log out",size: 18,weight: FontWeight.w500,color: Colors.white,),
                          Gap(15),
                          Image.asset("assets/icons/sign-out.png",width: 20,height: 20)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
