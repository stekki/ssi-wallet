import 'package:flutter/material.dart';

class DesignColors {
  static const mainColor = Color.fromARGB(255, 0, 212, 161);
  static const secondaryColor = Color.fromARGB(255, 255, 255, 255);
  static const tertiaryColor = Colors.grey;
  static const devRed = Color.fromARGB(192, 255, 61, 61);
}

class TextStyles {
  // logo text
  static const TextStyle logoText = TextStyle(
    fontFamily: "Piazzolla",
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: DesignColors.secondaryColor,
  );
  // appBar text
  static const TextStyle appBarText = TextStyle(
    fontFamily: "Piazzolla",
    fontSize: 25,
    fontWeight: FontWeight.normal,
    color: DesignColors.secondaryColor,
  );
  // medium text (card texts)
  static const TextStyle mediumText = TextStyle(
    fontFamily: "Piazzolla",
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: DesignColors.tertiaryColor,
  );
}

const scaffoldBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [
      0.2,
      0.8,
    ],
    colors: [
      DesignColors.mainColor,
      Colors.blue,
    ],
  ),
);
