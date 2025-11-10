import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/on_boarding_body.dart';

class onBoardingView extends StatelessWidget {
  const onBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: onBoardingViewBody(),
    );
  }
}
