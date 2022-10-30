import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../Module/onBoarding/onBoarding.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../social_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    late Widget widget;
    if (uId != null) {
      widget =  SocialLayout();
    } else {
      widget = const OnBoardingScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: EasySplashScreen(
          logo: Image.asset(
            'assets/images/logo.png',
          ),
          title: Text(
            'Twasol',
            style: Theme.of(context).textTheme.headline4?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
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
