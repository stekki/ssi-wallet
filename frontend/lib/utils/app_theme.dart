import 'package:flutter/material.dart';
import './styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(
        primary: DesignColors.mainColor,
        secondary: DesignColors.secondaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: DesignColors.extraColorWhite),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        borderSide: BorderSide(
          color: DesignColors.secondaryColor, // Adjust as needed
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        borderSide: BorderSide(
          color: DesignColors.secondaryColor,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        borderSide: BorderSide(
          color: DesignColors.extraColorWhite,
          width: 2.0,
        ),
      ),
      labelStyle: TextStyles.labelTitle,
      filled: true,
      fillColor: DesignColors.extraColorWhite,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: DesignColors.secondaryColor,
      labelColor: DesignColors.extraColorWhite,
      unselectedLabelColor: DesignColors.extraColorBlack,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          DesignColors.extraColorWhite,
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
          DesignColors.extraColorWhite,
        ),
      ),
    ),
    primaryColor: DesignColors.extraColorGray,
    scaffoldBackgroundColor: DesignColors.extraColorGray,
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
