import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
ThemeData lightMode = ThemeData(

  scaffoldBackgroundColor: Colors.white,
  primaryColor: primaryColor,
  primarySwatch: Colors.deepPurple,
  // Colors.blueGrey,

  appBarTheme: const AppBarTheme(
    centerTitle: false,
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600

    ),
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    selectedItemColor: primaryColor,
    elevation: 50.0,
  ),
  backgroundColor: Colors.white,
  fontFamily: 'janna',
);
ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.deepPurple ,
  // Colors.blueGrey,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,


    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    selectedItemColor: primaryColor,
  ),
  backgroundColor: Colors.white,
  fontFamily: 'janna',

);
