import 'package:flutter/material.dart';
import '../utils/styles.dart';

class LandingPageButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LandingPageButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20))),
          backgroundColor: const Color(0XFF07376F),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
        child: Text(
          text,
          style: TextStyles.lpButton,
        )
      ),
    );
  }
}