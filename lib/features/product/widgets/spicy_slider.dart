import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';
class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});

final double value;
final ValueChanged<double> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/sandwich.png",height: 225,),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text:"Customize Your Burger\n to Your Tastes.\n Ultimate Experience",),
            Gap(20),
            Slider(
              value: value,
              onChanged: onChanged,
              inactiveColor: Colors.grey.shade300,
              activeColor: AppColors.primary,
              min: 0,
              max: 1,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,                      children: [
              Image.asset("assets/icons/cold.png",height: 12,width: 15,),
              Gap(105),
              Image.asset("assets/icons/hot.png",height: 12,width: 15,),

            ],
            ),

          ],
        )
        ,
      ],
    );
  }
}
