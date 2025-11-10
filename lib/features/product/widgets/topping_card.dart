import 'package:flutter/material.dart';
import 'package:fruits_market_app/shared/custom_text.dart';

import '../../../core/constant/app_colors.dart';
class ToppingCard extends StatelessWidget {

final String imageUrl;
final String title;
final VoidCallback onAdd;

const ToppingCard({
  super.key,
  required this.imageUrl,
  required this.title,
  required this.onAdd,
});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 85,
            width: 100,
            color: AppColors.primary,

          ),
        ),

        Positioned(
          top: -40,
          right: -3,
          left: -3,
          child: SizedBox(
            height: 70,
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: Image.asset(imageUrl,fit: BoxFit.contain,),
            ),
          ),
        ),




        Positioned(
            right: 0,
            left: 0,
            bottom: 5,
            child:Padding(
              padding: EdgeInsets.all(12),
child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    CustomText(
      text:title ,
    color: Colors.white,
      size: 14,
      weight:  FontWeight.w600,

    ),

    GestureDetector(
      onTap: onAdd,
      child: const CircleAvatar(
        radius: 10,
        backgroundColor: Colors.red,
        child: Icon(Icons.add,color: Colors.white,
        size: 17,),
      ),
    )
  ],
),

            ),
        ),
      ],
    );
  }
}
