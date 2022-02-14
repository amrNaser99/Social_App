import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../Module/onBoarding/onBoarding.dart';
import '../../shared/components/constants.dart';
import '../social_layout.dart';

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    late Widget widget;
    if (uId != null) {
      widget = const SocialLayout();
    } else {
      widget = const OnBoardingScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: EasySplashScreen(
          logo: Image.asset(
            'assets/images/logo.png',
          ),
          title: Text(
            'Twasol',
            style: Theme.of(context).textTheme.headline5,
          ),
          durationInSeconds: 1,
          logoSize: 50,
          showLoader: true,
          navigator: MyApp(
            startWidget: widget,
          ),
        ),
      ),
    );
  }
}
