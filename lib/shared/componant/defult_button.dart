import 'package:flutter/cupertino.dart';
import 'package:fruits_market_app/shared/componant/componant.dart';

import '../../core/constant/app_colors.dart';

class DefultGeneralButton extends StatelessWidget {
  const DefultGeneralButton({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
         child:  Text(
           text!,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
      ),
    );
  }
}
