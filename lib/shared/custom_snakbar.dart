import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'custom_text.dart';

SnackBar customSnack(errorMsg){
  return  SnackBar(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: EdgeInsets.only(bottom: 30, right: 25, left: 20),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.none,
    backgroundColor: Colors.red.shade900,
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        Gap(15),
        Expanded(
          child: CustomText(
            text: errorMsg,
            color: Colors.white,
            size: 12,
            weight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}