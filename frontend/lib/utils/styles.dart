import 'package:flutter/material.dart';

class DesignColors {
  static const mainColor = Color.fromARGB(255, 0, 212, 161);
  static const secondaryColor = Color.fromARGB(255, 58, 78, 151);
  static const buttonColor = Color.fromARGB(255, 78, 207, 176);
  static const textColor = Color.fromARGB(255, 99, 99, 99);
  static const messageColor = Color.fromARGB(255, 187, 223, 231);
  static const extraColorWhite = Color.fromARGB(255, 255, 255, 255);
  static const extraColorGray = Color.fromARGB(255, 238, 238, 238);
  static const extraColorBlack = Color.fromARGB(120, 37, 31, 31);
  static const devRed = Color.fromARGB(192, 255, 61, 61);
  static const backgroundColor = Color.fromARGB(255, 255, 255, 255);
  static const greenCheckmark = Colors.green;
}

class TextStyles {
  static const TextStyle appBarUser = TextStyle(
    fontFamily: "Nunito",
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: DesignColors.secondaryColor,
    decoration: TextDecoration.underline,
  );
  // logo text
  static const TextStyle logoText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 35,
    fontWeight: FontWeight.w600,
    color: DesignColors.extraColorWhite,
  );
  // appBar text
  static const TextStyle appBarText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: DesignColors.extraColorWhite,
  );
  // scan screen text
  static const TextStyle scanScreenText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: DesignColors.mainColor,
  );

  // home screen floating button text
  static const TextStyle floatingButtonText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: DesignColors.mainColor,
  );

  static const TextStyle profileScreenText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 60, 60, 60),
  );

  // medium text (card subtitle, card texts)
  static const TextStyle mediumText = TextStyle(
    fontFamily: "Nunito",
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: DesignColors.secondaryColor,
  );
  // medium text (card titles)
  static const TextStyle mediumTitle = TextStyle(
    fontFamily: "Nunito",
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: DesignColors.secondaryColor,
  );
  // label title (sign in, register)
  static const TextStyle labelTitle = TextStyle(
    fontFamily: "Nunito",
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: DesignColors.extraColorGray,
  );

  static const TextStyle emailRegisTitle = TextStyle(
    fontFamily: "Nunito",
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: DesignColors.mainColor,
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

const connectionBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [
      0.01,
      0.99,
    ],
    colors: [
      DesignColors.extraColorWhite,
      DesignColors.messageColor,
    ],
  ),
);
