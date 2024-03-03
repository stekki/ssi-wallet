import 'package:flutter/material.dart';
import '../utils/styles.dart';

class LandingPageButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const LandingPageButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? DesignColors.buttonColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        )),
      ),
      onPressed: onPressed,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
          child: Text(text, style: TextStyles.labelTitle)),
    );
  }
}
