import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:gap/gap.dart';

import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';
class  UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(40),
            SvgPicture.asset(
              "assets/images/logo1.svg",
              color: AppColors.primary,
              height: 35,
            ),
            CustomText(
              text: "Hello, My Dear",
              size: 16,
              weight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ],
        ),
        Spacer(),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage("assets/images/profile2.jpg"),
                fit: BoxFit.cover,
              ),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 5,color: Colors.white)
          ),
        ),
      ],
    );
  }
}
