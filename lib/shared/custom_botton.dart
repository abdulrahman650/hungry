import 'package:flutter/material.dart';
import 'package:fruits_market_app/shared/custom_text.dart';

import '../core/constant/app_colors.dart';
class CustomBotton extends StatelessWidget {
  const CustomBotton({super.key, required this.text, this.onTap, this.width,  this.color, this.height});
final String text;
final double? width;
final double? height;
final Color? color;
final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
          height:height?? 45,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: color ?? AppColors.primary,
        ),
        child: Center(child: CustomText(text: text,color: Colors.white)),

      ),
    );
  }
}
