import 'package:flutter/material.dart';
import './styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: DesignColors.secondaryColor,
      labelColor: DesignColors.mainColor,
      unselectedLabelColor: DesignColors.extraColorBlack,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          DesignColors.mainColor,
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
          DesignColors.extraColorWhite,
        ),
      ),
    ),
    primaryColor: DesignColors.extraColorWhite,
    scaffoldBackgroundColor: DesignColors.mainColor,
    textTheme: const TextTheme(
      displayLarge: TextStyles.logoText,
      displayMedium: TextStyles.appBarText,
      bodyMedium: TextStyles.mediumText,
      titleMedium: TextStyles.mediumTitle,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: DesignColors.mainColor,
    ),
  );
}
