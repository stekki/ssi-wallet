import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';

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
    /*
    action: SnackBarAction(
      textColor: Colors.white,
      label: "OK",
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    */
    duration: const Duration(seconds: 3),
  ));
}
