import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'Module/register/register_screen.dart';
import 'layout/social_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  // await Firebase.initializeApp(options: const FirebaseOptions(
  //   appId: '1:109118035057:android:e4407e9a00abbbbb8237d0',
  //   apiKey: 'AIzaSyB2JmwyF_OHMbK26aEhXDsjXkAjmfjwpKw',
  //   projectId: 'social-app-d85e6',
  //   messagingSenderId: '109118035057',
  // ));

  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social App',
      theme: lightMode,
      darkTheme: darkMode,
      home: const SocialRegisterScreen(),
    );
  }
}
