import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';
import 'package:hungry_app/shared/custom_botton.dart';
import 'package:hungry_app/shared/custom_snakbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../shared/custom_text.dart';
import '../data/auth_repo.dart';
import '../widgets/custom_user_txtfield.dart';
import 'login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();
  UserModel? userModel;
  String? selectedImage;
  bool isLoading = true;
  bool isLoadingUpdate = false;
  bool isLoadingLogout = false;
  bool isProfileLoading = false;
  bool isGuest = false;
  AuthRepo authRepo = AuthRepo();

  ///وقفهم م,قتا
  //   Future<void> autoLogin() async {
  //     final user = await authRepo.autoLogin();
  //     setState(() => isGuest = authRepo.isGuest);
  //     if (user != null) setState(() => userModel = user);
  //   }
  //   Future<void> getProfileData() async {
  //     if (isProfileLoading) return; // يمنع التكرار
  //     isProfileLoading = true;
  //     try {
  //       final user = await authRepo.getProfileData();
  //       if (user != null) {
  //         setState(() {
  //           userModel = user;
  //           _name.text = userModel?.name ?? "";
  //           _email.text = userModel?.email ?? "";
  //           _address.text = userModel?.address ?? "";
  //         });
  //       }
  //     } catch (e) {
  //       String errorMsg = e is ApiError ? e.message : "Error in Profile";
  //       ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
  //     } finally {
  //       isProfileLoading = false;
  //     }
  //   }

  /// update profile
  Future<void> updateProfileData() async {
    try {
      setState(() => isLoadingUpdate = true);
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        imagePath: selectedImage,
        visa: _visa.text.trim(),
      );
      setState(() => userModel = authRepo.currentUser);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack('Profile updated Successfully'));
    } catch (e) {
      setState(() => isLoadingUpdate = false);
      String errorMsg = 'Failed to update profile';
      if (e is ApiError) errorMsg = e.message;
      print(errorMsg);
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      setState(() => isLoadingLogout = true);
      await authRepo.logout();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => LoginView()),
      );
      setState(() => isLoadingLogout = false);
    } catch (e) {
      setState(() => isLoadingLogout = false);
      print(e.toString());
    }
  }

  /// pick image
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  Future<void> initProfile() async {
    setState(() => isLoading = true);

    // جلب حالة الجست + توكن
    await authRepo.autoLogin(); // هيضبط authRepo.currentUser و isGuest داخليًا

    // مزامنة المتغير المحلي
    isGuest = authRepo.isGuest;
    userModel = authRepo.currentUser;

    if (!isGuest && userModel == null) {
      // لو مستخدم مسجل ومافيش بيانات بعد
      userModel = await authRepo.getProfileData();
    }

    if (userModel != null) {
      _name.text = userModel!.name ?? "abdulrahman";
      _email.text = userModel!.email ?? "abulrahman@gmail.com";
      _address.text = userModel!.address ?? "";
    }

    setState(() => isLoading = false);
  }


  @override
  void initState() {
    super.initState();
    initProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!isGuest) {
      return RefreshIndicator(
        displacement: 60,
        color: Colors.red,
        backgroundColor: AppColors.primary,
        onRefresh: () async {
          userModel = authRepo.currentUser;
          // await getProfileData();
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.primary,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.primary,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Skeletonizer(
                  enabled: userModel == null,
                  child: Column(
                    children: [
                      Gap(16),
                      Container(
                        height: 120,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          border: Border.all(width: 3, color: Colors.white),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: selectedImage != null
                            ? Image.file(
                                File(selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : (userModel?.image != null &&
                                  userModel!.image!.isNotEmpty)
                            ? Image.network(
                                userModel!.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Image.asset(
                                  "assets/images/profilemw.jpg",
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                "assets/images/profilemw.jpg",
                                fit: BoxFit.cover,
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: Card(
                              elevation: 0.0,
                              color: const Color.fromARGB(255, 6, 78, 13),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'Upload',
                                      weight: FontWeight.w500,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    Gap(10),
                                    Icon(
                                      CupertinoIcons.camera,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: pickImage,
                            child: Card(
                              elevation: 0.0,
                              color: const Color.fromARGB(255, 111, 2, 40),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'Remove',
                                      weight: FontWeight.w500,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    Gap(10),
                                    Icon(
                                      CupertinoIcons.trash,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      CustomUserTxtfield(controller: _name, label: "Name"),
                      Gap(20),
                      CustomUserTxtfield(controller: _email, label: "Email"),
                      Gap(20),
                      CustomUserTxtfield(
                        controller: _address,
                        label: "Address",
                      ),
                      Gap(20),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0, left: 35.0),
                        child: Divider(),
                      ),
                      Gap(20),

                      userModel?.visa == null
                          ? CustomUserTxtfield(
                              controller: _visa,
                              label: "ADD VISA CARD",
                              textInputType: TextInputType.number,
                            )
                          : ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              tileColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 16,
                              ),
                              leading: Image.asset(
                                "assets/icons/profile_visa.png",
                                width: 60,
                              ),
                              title: CustomText(
                                text: "Debit card",
                                color: Colors.black,
                              ),
                              subtitle: CustomText(
                                text: userModel?.visa ?? "3434 **** **** 4123",
                                color: Colors.grey.shade900,
                              ),
                              trailing: CustomText(
                                text: "Default",
                                color: Colors.black,
                              ),
                            ),
                      Gap(300),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    // edit
                    isLoadingUpdate
                        ? CupertinoActivityIndicator(color: AppColors.primary)
                        : Expanded(
                            child: GestureDetector(
                              onTap: updateProfileData,
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: AppColors.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: CustomText(
                                    text: "Edit Profile",
                                    size: 18,
                                    weight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Gap(20),
                    // logout
                    Expanded(
                      child: GestureDetector(
                        onTap: logout,
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "Log out",
                              size: 18,
                              weight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (isGuest) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Guest Mode')),
            Gap(20),
            CustomBotton(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (c) => LoginView()),
              ),
              text: 'Go to Login',
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}
