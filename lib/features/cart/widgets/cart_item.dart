import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/app_colors.dart';
import '../../../shared/custom_text.dart';
class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.isLoading,
    this.onAdd,
    this.onMin,
    this.onRem,

    required this.number});
  final String image,text,desc;
  final Function()? onAdd;
  final Function()? onMin;
  final Function()? onRem;
  final bool isLoading;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(image, width: 100,),
                  CustomText(text: text,weight: FontWeight.bold,) ,
                  CustomText(text: desc),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap:onAdd,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Gap(20),
                    CustomText(text: number.toString(),weight: FontWeight.w400,size: 20,) ,
                    Gap(20),
                    GestureDetector(
                      onTap:onMin,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(CupertinoIcons.minus,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(20),

                GestureDetector(
                  onTap: onRem,
                  child: Container(
                    width: 130,
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(9)
                    ),
                    child:
                    isLoading ? CupertinoActivityIndicator(color: Colors.white,):
                    Center(child: CustomText(text: "Remove",color: Colors.white,)),

                  ),
                ),                      ],
            ),
          ],
        ),
      ),
    );
  }
}
