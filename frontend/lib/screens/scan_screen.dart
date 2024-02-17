import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: scaffoldBackground,
        child: const Center(
          child: Text("Scan Screen"),
        ),
      ),
    );
  }
}
