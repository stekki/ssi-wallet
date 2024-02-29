import 'package:flutter/material.dart';

class DesignColors {
  static const mainColor = Color.fromARGB(255, 0, 212, 161);
  static const secondaryColor = Color.fromARGB(255, 50, 103, 141);
  static const extraColorWhite = Color.fromARGB(255, 255, 255, 255);
  static const extraColorGray = Color.fromARGB(255, 238, 238, 238);
  static const extraColorBlack = Color.fromARGB(120, 37, 31, 31);
  static const devRed = Color.fromARGB(192, 255, 61, 61);
}

class TextStyles {
  // logo text
  static const TextStyle appBarUser = TextStyle(
    fontFamily: "Nunito Sans",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
    decoration: TextDecoration.underline,
  );
  // logo text
  static const TextStyle logoText = TextStyle(
    fontFamily: "Nunito Sans",
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: DesignColors.extraColorWhite,
  );
  // appBar text
  static const TextStyle appBarText = TextStyle(
    fontFamily: "Nunito Sans",
    fontSize: 25,
    fontWeight: FontWeight.normal,
    color: DesignColors.extraColorWhite,
  );
  // medium text (card subtitle, card texts)
  static const TextStyle mediumText = TextStyle(
    fontFamily: "Nunito Sans",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
  // medium text (card titles)
  static const TextStyle mediumTitle = TextStyle(
    fontFamily: "Nuniito Sans",
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
  // label title (sign in, register)
  static const TextStyle labelTitle = TextStyle(
    fontFamily: "Nunito Sans",
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
}

const scaffoldBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [
      0.01,
      0.99,
    ],
    colors: [
      DesignColors.mainColor,
      DesignColors.secondaryColor,
    ],
  ),
);
