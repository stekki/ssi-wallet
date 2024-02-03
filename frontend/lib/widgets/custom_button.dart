import 'package:flutter/material.dart';
import '../utils/styles.dart';

class LandingPageButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const LandingPageButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(height * 0.03875),
                right: Radius.circular(height * 0.03875),
              )),
          backgroundColor: const Color(0XFF07376F),
          padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.05, width * 0.05, height * 0.05)
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyles.lpButton(height),
      ),
    );
  }
}
