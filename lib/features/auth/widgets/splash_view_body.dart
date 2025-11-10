import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_market_app/layout.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../core/constant/app_colors.dart';
import '../../../shared/componant/componant.dart';
import '../views/on_boarding/on_boarding_view.dart';


class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>with SingleTickerProviderStateMixin {
  double _opacity =0.0;
  
  @override

void initState(){
    super.initState();
    Future.delayed(
      Duration(milliseconds: 200,),(){
        setState(()=> _opacity =1.0);
    } );
    Future.delayed(
        Duration(seconds: 3,),
          ()=> Navigator.push(context,
              MaterialPageRoute(builder: (c)=> Layout()),
          )

    );
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Container(
      color: AppColors.primary,
      child: AnimatedOpacity(
        duration:  Duration(seconds: 1,),
        opacity: _opacity,
        curve: Curves.easeOutBack,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(300),
            TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8,end: 1.0),
                duration: Duration(milliseconds: 800,),
                curve: Curves.easeOutBack,
                builder: ( context, scale, child)=> Transform.scale(
                    scale: scale,
                child: child,
                ),
                child: SvgPicture.asset("assets/images/logo1.svg")),
            Spacer(),
            TweenAnimationBuilder(
                tween: Tween(begin: 40.0,end: 0.0),
                duration: Duration(milliseconds: 900,),
                curve:Curves.easeOutCubic,
                builder: ( context, value,child)=> Transform.translate(
                    offset:Offset(0,value),
                child: child,
                ),
                child: Image.asset('assets/images/splash_image.png')),


          ],
        ),
      ),


    );
  }


}
