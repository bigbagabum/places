import 'package:flutter/material.dart';
import 'package:places/ui/res/app_theme.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  selectedRowColor: AppColors.rowSelectedColorGreen,
  scaffoldBackgroundColor: AppColors.dmBackground,
  primaryColorDark: AppColors.dmCardBackground, //фон карточек и инпутов
  primaryColorLight: AppColors.dmPrimaryLightColor,
  secondaryHeaderColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.dmBackground,
  ),
  // ignore: prefer_const_constructors
  textTheme: TextTheme(
    button: const TextStyle(
        fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    bodyText1: const TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: Colors.green),
    headline1: const TextStyle(
        fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    // ignore: prefer_const_constructors
    headline2: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    headline3: const TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.lightGrey),
    headline5: const TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
        color: AppColors.dmPrimaryLightColor),
    headline4: const TextStyle(
        fontSize: 14,
        fontFamily: 'Roboto',
        color: AppColors.dmPrimaryLightColor),
    headline6: const TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
        color: Color.fromARGB(255, 196, 37, 37),
        fontWeight: FontWeight.bold),

    subtitle1: const TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      color: AppColors.lightGrey,
      fontWeight: FontWeight.bold,
    ),
    subtitle2: const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      color: AppColors.lightGrey,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.green),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    fillColor: AppColors.dmCardBackground,
    filled: true,
    labelStyle: const TextStyle(
      color: AppColors.lightGrey,
    ),
    hintStyle: const TextStyle(
      color: AppColors.lightGrey,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  ),
);

final lightTheme = ThemeData(
  selectedRowColor: AppColors.rowSelectedColorGreen,
  primaryColorDark: AppColors.lightGrey,
  primaryColorLight: AppColors.dmCardBackground,
  scaffoldBackgroundColor: AppColors.dmPrimaryLightColor,
  secondaryHeaderColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.dmPrimaryLightColor,
  ),
  textTheme: const TextTheme(
    button: TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    bodyText1:
        TextStyle(fontSize: 16, fontFamily: 'Roboto', color: Colors.green),
    headline1:
        TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    headline2: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    headline3: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    headline4: TextStyle(
        fontSize: 14, fontFamily: 'Roboto', color: AppColors.dmBackground),
    headline5: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.dmCardBackground),
    headline6: TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
        color: AppColors.dmCardBackground,
        fontWeight: FontWeight.bold),
    subtitle1: TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      color: AppColors.darkGrey,
      fontWeight: FontWeight.bold,
    ),
    subtitle2: TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      color: AppColors.darkGrey,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.darkGrey,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.green),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lightGrey,
        width: 1.0,
      ),
    ),
    fillColor: AppColors.dmPrimaryLightColor,
    filled: true,
    labelStyle: const TextStyle(
      color: Colors.black,
    ),
    hintStyle: const TextStyle(
      color: Colors.black,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  ),
);
