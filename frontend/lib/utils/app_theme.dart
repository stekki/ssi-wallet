import 'package:flutter/material.dart';

import 'styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(
        primary: DesignColors.mainColor,
        secondary: DesignColors.secondaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: DesignColors.mainColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(color: DesignColors.mainColor, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: DesignColors.mainColor,
          width: 1.0,
        ),
      ),
      labelStyle: TextStyles.emailRegisTitle,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: DesignColors.secondaryColor,
      labelColor: DesignColors.mainColor,
      unselectedLabelColor: DesignColors.extraColorBlack,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          DesignColors.mainColor,
        ), //button color
        foregroundColor: WidgetStateProperty.all<Color>(
          DesignColors.extraColorWhite,
        ),
      ),
    ),
    primaryColor: DesignColors.extraColorWhite,
    scaffoldBackgroundColor: DesignColors.backgroundColor,
    textTheme: const TextTheme(
      displayLarge: TextStyles.logoText,
      displayMedium: TextStyles.appBarText,
      displaySmall: TextStyles.appBarUser,
      bodyMedium: TextStyles.mediumText,
      titleMedium: TextStyles.mediumTitle,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: DesignColors.mainColor,
    ),
  );
}
