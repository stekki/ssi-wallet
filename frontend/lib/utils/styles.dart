import 'package:flutter/material.dart';

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
        fontSize: 30,
        fontWeight: FontWeight.w600,
        fontFamily: "Piazzolla",
  );
  
  //Landing page text style
  static const TextStyle lpText = TextStyle(
          color: Color(0XFF07376F),
          fontStyle: FontStyle.normal,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: "Piazzolla",
  );

  //Landing page button text style
  static const TextStyle lpButton = TextStyle(
          color: Color(0XFFE6EDFF),
          fontStyle: FontStyle.normal,
          fontSize: 23,
          fontWeight: FontWeight.w700,
  );
}