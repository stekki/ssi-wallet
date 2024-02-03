import 'package:flutter/material.dart';

class DesignColors {
  final mainColor = const Color(0XFF07376F);
  final secondaryColor =
  const Color.fromARGB(1, 182, 218, 255).withOpacity(0.5);
  final tertiaryColor = const Color(0XFFE6EDFF);
}

class TextStyles {

  //Landing page title style
  static TextStyle lpTitle(double height) {
    return TextStyle(
      color: const Color.fromARGB(255, 94, 136, 180),
      fontSize: height * 0.09,
      fontWeight: FontWeight.w500,
    );}

  //Landing page welcome text style
  static TextStyle lpWelcome(double height) {
    return TextStyle(
      color: const Color(0XFF07376F),
      fontStyle: FontStyle.normal,
      fontSize: height * 0.042,
      fontWeight: FontWeight.w800,
      fontFamily: "Piazzolla",
    );}

  //Landing page text style
  static TextStyle lpText(double height) {
    return TextStyle(
      color: const Color(0XFF07376F),
      fontStyle: FontStyle.normal,
      fontSize: height * 0.0345,
      fontWeight: FontWeight.w600,
      fontFamily: "Piazzolla",
    );}

  //Landing page button text style
  static TextStyle lpButton(double height){
    return TextStyle(
      color: const Color(0XFFE6EDFF),
      fontStyle: FontStyle.normal,
      fontSize: height * 0.0345,
      fontWeight: FontWeight.w700,
    );}

  static TextStyle lpRegisterText(double height){
    return TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: height * 0.0255,
      color: const Color(0XFF07376F),
    );}

  static TextStyle lpSignUpText(double height){
    return TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: height * 0.03,
    );}

  static TextStyle rpRegisterText(double height){
    return TextStyle(
      color: const Color(0XFF07376F),
      fontStyle: FontStyle.normal,
      fontSize: height * 0.045,
      fontWeight: FontWeight.w500,
      fontFamily: "Piazzolla",
    );}

  static TextStyle rpEmailText(double height){
    return TextStyle(
      color: const Color(0XFF07376F),
      fontStyle: FontStyle.normal,
      fontSize: height * 0.045,
      fontWeight: FontWeight.w900,
      fontFamily: "Piazzolla",
    );}

}
