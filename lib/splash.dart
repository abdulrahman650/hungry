 import 'package:flutter/material.dart';

import 'core/constant/app_colors.dart';
import 'features/auth/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primary,
      body:SplashBody(),
    );
  }
}
