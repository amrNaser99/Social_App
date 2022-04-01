import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  if(permissionsGranted == null || permissionsGranted == false){
  await PermissionHandler.appPermission();
  }
  //when the app is opened
  FirebaseMessaging.onMessage.listen((event) {});
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  // background notification
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  // var r = await FirebaseMessaging.instance.getToken();
  // print('=================token=============================');
  // print(r);

  // bool onBoarding = false;
  uId = CacheHelper.getData(key: 'uId');
  permissionsGranted = CacheHelper.getData(key: 'permissionsGranted');


  BlocOverrides.runZoned(
    () {
      runApp(splashScreen());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getDataUser()
            ..getPosts(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social App',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}


// const AndroidInitializationSettings androidInitialization =
// AndroidInitializationSettings('launcher_icon');
// const IOSInitializationSettings iosInitialization =
// IOSInitializationSettings();
// const InitializationSettings initializationSettings =
// InitializationSettings(
//   android: androidInitialization,
//   iOS: iosInitialization,
// );
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// flutterLocalNotificationsPlugin.initialize(
// initializationSettings,
// // onSelectNotification: onSelectNotification,
// );
