import 'package:flutter/material.dart';

class DesignColors {
  static const mainColor = Color.fromARGB(255, 0, 212, 161);
  static const secondaryColor = Color.fromARGB(255, 50, 103, 141);
  static const buttonColor = Color.fromARGB(255, 78, 207, 176);
  static const textColor = Color.fromARGB(255, 99, 99, 99);
  static const messageColor = Color.fromARGB(255, 187, 223, 231);
  static const extraColorWhite = Color.fromARGB(255, 255, 255, 255);
  static const extraColorGray = Color.fromARGB(255, 238, 238, 238);
  static const extraColorBlack = Color.fromARGB(120, 37, 31, 31);
  static const devRed = Color.fromARGB(192, 255, 61, 61);
}

class TextStyles {
  // logo text
  static const TextStyle appBarUser = TextStyle(
    fontFamily: "Nunito",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
    decoration: TextDecoration.underline,
  );
  // logo text
  static const TextStyle logoText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: DesignColors.extraColorWhite,
  );
  // appBar text
  static const TextStyle appBarText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 25,
    fontWeight: FontWeight.normal,
    color: DesignColors.extraColorWhite,
  );
  // medium text (card subtitle, card texts)
  static const TextStyle mediumText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
  // medium text (card titles)
  static const TextStyle mediumTitle = TextStyle(
    fontFamily: "Nunito",
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
  // label title (sign in, register)
  static const TextStyle labelTitle = TextStyle(
    fontFamily: "Nunito",
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: DesignColors.extraColorGray,
  );
}

const scaffoldBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
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
