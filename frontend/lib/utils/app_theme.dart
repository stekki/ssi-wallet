import 'package:flutter/material.dart';
import './styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: DesignColors.tertiaryColor,
      labelColor: DesignColors.mainColor,
      unselectedLabelColor: DesignColors.tertiaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          DesignColors.mainColor,
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
          DesignColors.secondaryColor,
        ),
      ),
    ),
    primaryColor: DesignColors.secondaryColor,
    scaffoldBackgroundColor: DesignColors.mainColor,
    textTheme: const TextTheme(
      displayLarge: TextStyles.logoText,
      displayMedium: TextStyles.appBarText,
      bodyMedium: TextStyles.mediumText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: DesignColors.mainColor,
    ),
  );
}
