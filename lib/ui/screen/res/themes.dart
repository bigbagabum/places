import 'package:flutter/material.dart';
import 'package:places/ui/res/app_theme.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.dmBackground,
  primaryColorDark: AppColors.dmCardBackground, //фон карточек и инпутов
  primaryColorLight: AppColors.dmPrimaryLightColor,
  secondaryHeaderColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.dmBackground,
  ),
  // ignore: prefer_const_constructors
  textTheme: TextTheme(
      headline1:
          TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
      // ignore: prefer_const_constructors
      headline2: TextStyle(
          fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
      headline3: const TextStyle(
          fontSize: 16, fontFamily: 'Roboto', color: AppColors.lightGrey),
      headline5: const TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          color: AppColors.dmPrimaryLightColor),
      headline4: TextStyle(
          fontSize: 14,
          fontFamily: 'Roboto',
          color: AppColors.dmPrimaryLightColor)),
);

final lightTheme = ThemeData(
  primaryColorDark: AppColors.lightGrey,
  primaryColorLight: AppColors.dmCardBackground,
  scaffoldBackgroundColor: AppColors.dmPrimaryLightColor,
  secondaryHeaderColor: AppColors.darkGrey,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.dmPrimaryLightColor,
  ),
  textTheme: const TextTheme(
    headline1:
        TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    headline2: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    headline3: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
    headline4: TextStyle(
        fontSize: 14, fontFamily: 'Roboto', color: AppColors.dmBackground),
    headline5: const TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.dmCardBackground),
  ),
);
