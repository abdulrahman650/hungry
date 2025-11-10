import 'package:flutter/material.dart';
import 'package:fruits_market_app/shared/componant/defult_button.dart';

import '../../../shared/componant/componant.dart';


class onBoardingViewBody extends StatelessWidget {
  const onBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top:SizeConfig.defaultSize! * 10,
          right: 32,
          child: Text(
          'Skip',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xff898989),
            ),
            textAlign: TextAlign.left,
              ),
        ),
        Positioned(
          left: SizeConfig.defaultSize!*10,
          right: SizeConfig.defaultSize!*10,
            bottom: SizeConfig.defaultSize!*10,
            child: DefultGeneralButton(
              text: "Next",
            )),
      ],
    );
  }
}
