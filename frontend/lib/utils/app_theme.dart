import 'package:flutter/material.dart';
import './styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: DesignColors.secondaryColor,
    scaffoldBackgroundColor: DesignColors.mainColor,
    textTheme: TextTheme(
        // logo text
        displayLarge: const TextStyle().copyWith(
          fontFamily: "Piazzolla",
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: DesignColors.secondaryColor,
        ),
        // appbar text
        displayMedium: const TextStyle().copyWith(
          fontFamily: "Piazzolla",
          fontSize: 25,
          fontWeight: FontWeight.normal,
          color: DesignColors.secondaryColor,
        ),
        bodyMedium: const TextStyle().copyWith(
          fontFamily: "Piazzolla",
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: DesignColors.secondaryColor,
        ),
        bodyLarge: const TextStyle().copyWith(
          fontFamily: "Piazzolla",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: DesignColors.secondaryColor,
        )),
    appBarTheme: const AppBarTheme(
      backgroundColor: DesignColors.mainColor,
    ),
  );
}
