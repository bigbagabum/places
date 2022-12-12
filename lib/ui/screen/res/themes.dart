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
  textTheme: TextTheme(
    headline1:
        TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
    headline2: TextStyle(
        fontSize: 16, fontFamily: 'Roboto', color: AppColors.darkGrey),
  ),
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
    ));
