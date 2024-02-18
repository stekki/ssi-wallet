import 'package:flutter/material.dart';

class DesignColors {
  static const mainColor = Color.fromARGB(255, 0, 212, 161);
  static const secondaryColor = Color.fromARGB(255, 30, 69, 154);
  static const extraColorWhite = Color.fromARGB(255, 255, 255, 255);
  static const extraColorGray = Color.fromARGB(120, 255, 255, 255);
  static const extraColorBlack = Color.fromARGB(120, 37, 31, 31);
  static const devRed = Color.fromARGB(192, 255, 61, 61);
}

class TextStyles {
  // logo text
  static const TextStyle logoText = TextStyle(
    fontFamily: "Piazzolla",
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: DesignColors.extraColorWhite,
  );
  // appBar text
  static const TextStyle appBarText = TextStyle(
    fontFamily: "Piazzolla",
    fontSize: 25,
    fontWeight: FontWeight.normal,
    color: DesignColors.extraColorWhite,
  );
  // medium text (card subtitle, card texts)
  static const TextStyle mediumText = TextStyle(
    fontFamily: "Piazzolla",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
  // medium text (card titles)
  static const TextStyle mediumTitle = TextStyle(
    fontFamily: "Piazzolla",
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
  // label title (sign in, register)
  static const TextStyle labelTitle = TextStyle(
    fontFamily: "Piazzolla",
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
      0.3,
      0.7,
    ],
    colors: [
      DesignColors.secondaryColor,
      DesignColors.mainColor,
    ],
  ),
);
