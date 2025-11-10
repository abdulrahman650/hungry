import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruits_market_app/splash.dart';
import 'package:get/get.dart';

import 'features/auth/views/login_view.dart';
import 'features/auth/views/signup_view.dart';
import 'features/auth/widgets/splash_view_body.dart';
import 'layout.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ]
  );
  runApp(Hungry());
}

class Hungry extends StatelessWidget {
  const Hungry({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp (
      debugShowCheckedModeBanner: false,
      title: "Hungry App",
      theme: ThemeData(
         splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginView(),
          );
  }
}
