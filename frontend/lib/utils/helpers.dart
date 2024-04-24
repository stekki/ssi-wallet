import 'package:flutter/material.dart';

import '../utils/styles.dart';

void showInfoSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Align(
        alignment: Alignment.center,
        child: Text(message),
      ),
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22), topRight: Radius.circular(22))),
    backgroundColor: DesignColors.mainColor,
    duration: const Duration(seconds: 3),
  ));
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Align(
        alignment: Alignment.center,
        child: Text(message),
      ),
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22), topRight: Radius.circular(22))),
    backgroundColor: const Color.fromARGB(255, 212, 0, 0),
    duration: const Duration(seconds: 3),
  ));
}
