import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialApp/Module/onBoarding/onBoarding.dart';
import 'package:socialApp/shared/bloc_observer.dart';
import 'package:socialApp/shared/components/constants.dart';
import 'package:socialApp/shared/cubit/social_cubit.dart';
import 'package:socialApp/shared/network/local/cache_helper.dart';
import 'package:socialApp/shared/styles/themes.dart';

import 'Module/login/social_login_screen.dart';
import 'layout/social_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;
  // bool onBoarding = false;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = const OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getDataUser()..getPosts(),
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
