import 'package:flutter/material.dart';
import 'package:places/ui/res/app_theme.dart';

final darkTheme = ThemeData(
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
    // headlineSmall:
    //     TextStyle(fontSize: 16, fontFamily: 'Roboto', color: Colors.green),
    displayLarge:
        const TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    // ignore: prefer_const_constructors
    displayMedium: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    displaySmall: const TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.lightGrey),
    headlineSmall: const TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
        color: AppColors.dmPrimaryLightColor),
    headlineMedium: const TextStyle(
        fontSize: 14,
        fontFamily: 'Roboto',
        color: AppColors.dmPrimaryLightColor),
    titleLarge: const TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
        color: AppColors.dmCardBackground,
        fontWeight: FontWeight.bold),

    titleMedium: const TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      color: AppColors.lightGrey,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle(
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
  primaryColorDark: AppColors.lightGrey,
  primaryColorLight: AppColors.dmCardBackground,
  scaffoldBackgroundColor: AppColors.dmPrimaryLightColor,
  secondaryHeaderColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.dmPrimaryLightColor,
  ),
  textTheme: const TextTheme(
    // headlineSmall:
    //     TextStyle(fontSize: 16, fontFamily: 'Roboto', color: Colors.green),
    displayLarge:
        TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    displaySmall: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    headlineMedium: TextStyle(
        fontSize: 14, fontFamily: 'Roboto', color: AppColors.dmBackground),
    headlineSmall: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.dmCardBackground),
    titleLarge: TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
        color: AppColors.dmCardBackground,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      color: AppColors.darkGrey,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
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
