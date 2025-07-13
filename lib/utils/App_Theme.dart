import 'package:flutter/material.dart';
import 'package:untitled15/utils/App_Color.dart';

class AppTheme{
  static ThemeData darkTheme = ThemeData(
    focusColor: AppColors.primaryDarkColor,
    scaffoldBackgroundColor: AppColors.primaryDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDarkColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:AppColors.primaryDarkColor
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        backgroundColor: AppColors.white
      )
    )
  );
  static ThemeData lightTheme = ThemeData(
    focusColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor
    ),
      textTheme: TextTheme(
          headlineLarge: TextStyle(

          )
      )
  );
}