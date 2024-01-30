import 'package:flutter/material.dart';

class DesignColors {
  final mainColor = const Color(0XFF07376F);
  final secondaryColor =
      const Color.fromARGB(1, 182, 218, 255).withOpacity(0.5);
  final tertiaryColor = const Color(0XFFE6EDFF);
}

class TextStyles {
  //Landing page title style
  static const TextStyle lpTitle = TextStyle(
    color: Color.fromARGB(255, 94, 136, 180),
    fontSize: 60,
    fontWeight: FontWeight.w500,
  );

  //Landing page welcome text style
  static const TextStyle lpWelcome = TextStyle(
    color: Color(0XFF07376F),
    fontStyle: FontStyle.normal,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    fontFamily: "Piazzolla",
  );

  //Landing page text style
  static const TextStyle lpText = TextStyle(
    color: Color(0XFF07376F),
    fontStyle: FontStyle.normal,
    fontSize: 23,
    fontWeight: FontWeight.w600,
    fontFamily: "Piazzolla",
  );

  //Landing page button text style
  static const TextStyle lpButton = TextStyle(
    color: Color(0XFFE6EDFF),
    fontStyle: FontStyle.normal,
    fontSize: 23,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle lpRegisterText = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 17,
    color: Color(0XFF07376F),
  );

  static const TextStyle lpSignUpText = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 20,
  );

  static const TextStyle rpRegisterText = TextStyle(
    color: Color(0XFF07376F),
    fontStyle: FontStyle.normal,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    fontFamily: "Piazzolla",
  );

  static const TextStyle rpEmailText = TextStyle(
    color: Color(0XFF07376F),
    fontStyle: FontStyle.normal,
    fontSize: 30,
    fontWeight: FontWeight.w900,
    fontFamily: "Piazzolla",
  );
}
