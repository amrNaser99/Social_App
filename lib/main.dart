import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/Module/auth/login/cubit/social_login_cubit.dart';
import 'package:twasol/Module/auth/register/register_cubit/social_register_cubit.dart';
import 'package:twasol/layout/splash/splash_screen.dart';
import 'package:twasol/shared/bloc_observer.dart';
import 'package:twasol/shared/components/constants.dart';
import 'package:twasol/shared/components/permissions.dart';
import 'package:twasol/shared/cubit/social_cubit.dart';
import 'package:twasol/shared/network/local/cache_helper.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  // NotificationServices().initNotification();
  // AwesomeNotifications().initialize(
  //   'resource://drawable/res_app_icon',
  //   [
  //     NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: Colors.blue,
  //       ledColor: Colors.white,
  //     ),
  //   ],
  // );

  //when the app is opened
  FirebaseMessaging.onMessage.listen((event) {});
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  // background notification
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // bool onBoarding = false;
  uId = CacheHelper.getData(key: 'uId');
  permissionsGranted = CacheHelper.getData(key: 'permissionsGranted');

  BlocOverrides.runZoned(
    () {
      runApp(const SplashScreen());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({
    super.key,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getDataUser()
            ..getPosts()
            ..getFcmToken()
            ..getNotifications(),
        ),
        BlocProvider(create: (context) => SocialLoginCubit()),
        BlocProvider(create: (context) => SocialRegisterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twasol',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
