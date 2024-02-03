import 'package:flutter/material.dart';

class Constants {
  static const lpLoginButtonSpacing = 40.0;
}

class DesignColors {
  static const mainColor = Color(0XFF07376F);
  static const secondaryColor = Color.fromRGBO(101, 178, 255, 0.498);
  static const tertiaryColor = Color.fromARGB(255, 236, 241, 255);
  static const lpTitleTextColor = Color.fromARGB(255, 0, 0, 0);
  static const lpButtonColor = Color.fromARGB(255, 43, 142, 255);
  static const lpButtonTextColor = Color.fromARGB(255, 255, 255, 255);
  static const devRed = Color.fromARGB(192, 255, 61, 61);
}

class TextStyles {
  //Landing page title style
  static const TextStyle lpTitle = TextStyle(
    color: DesignColors.lpTitleTextColor,
    fontSize: 60,
    fontWeight: FontWeight.w500,
  );

  //Landing page welcome text style
  static const TextStyle lpWelcome = TextStyle(
    color: DesignColors.mainColor,
    fontStyle: FontStyle.normal,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    fontFamily: "Piazzolla",
  );

  //Landing page text style
  static const TextStyle lpText = TextStyle(
    color: DesignColors.mainColor,
    fontStyle: FontStyle.normal,
    fontSize: 23,
    fontWeight: FontWeight.w600,
    fontFamily: "Piazzolla",
  );

  //Landing page button text style
  static const TextStyle lpButton = TextStyle(
    color: DesignColors.lpButtonTextColor,
    fontStyle: FontStyle.normal,
    fontSize: 23,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle lpRegisterText = TextStyle(
    color: DesignColors.mainColor,
    fontWeight: FontWeight.w300,
    fontSize: 17,
  );

  static const TextStyle lpSignUpText = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 20,
  );

  static const TextStyle rpRegisterText = TextStyle(
    color: DesignColors.mainColor,
    fontStyle: FontStyle.normal,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    fontFamily: "Piazzolla",
  );

  static const TextStyle rpEmailText = TextStyle(
    color: DesignColors.mainColor,
    fontStyle: FontStyle.normal,
    fontSize: 30,
    fontWeight: FontWeight.w900,
    fontFamily: "Piazzolla",
  );

  static const lsText = TextStyle(
    color: DesignColors.mainColor,
    fontWeight: FontWeight.w300,
    fontSize: 35.0,
  );
}
