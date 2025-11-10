import 'package:flutter/material.dart';

import '../core/constant/app_colors.dart';
import 'custom_text.dart';
class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, this.onTap, required this.text, this.color, this.textColor});
final Function() ? onTap;
final String text;
final Color? color;
final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white,
          )
        ),
        width: double.infinity,
        child: Center(
          child: CustomText(text: text,
            weight: FontWeight.w700,
            color:textColor ?? AppColors.primary,
            size: 15,

          ),
        ),
      ),
    );
  }
}
