import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  /*
  void popUntilRoot(BuildContext context) {
    while (context.canPop()) {  
      context.pop();
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Scan Screen"),
      ),
    );
  }
}
