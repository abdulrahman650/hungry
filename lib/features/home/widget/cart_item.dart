import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruits_market_app/core/constant/app_colors.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_text.dart';
class CardItem extends StatelessWidget {
  const CardItem(
       {super.key,
         required this.image,
         required this.text,
         required this.desc,
         required this.rate,
       });
final String image, text, desc, rate;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(image,width: 120,height: 120,)),
            Gap(10),
            CustomText(text: text,
              weight: FontWeight.bold,),
            CustomText(text: desc,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/icons/star.png",
                  height: 16,
                  width: 15,
                ),
                CustomText(text: rate,),
                Spacer(),
                Icon(CupertinoIcons.heart,color:AppColors.primary ,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
