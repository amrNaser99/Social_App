import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twasol/shared/styles/colors.dart';

ThemeData lightMode = ThemeData(
    primarySwatch: primaryColor,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: w,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // type: BottomNavigationBarType.fixed,
      selectedItemColor: mainColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
      subtitle2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      )
    ),
    fontFamily: 'janna');



ThemeData darkMode = ThemeData(
  primarySwatch: primaryColor,
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
  ),
  fontFamily: 'janna',
);
