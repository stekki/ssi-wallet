import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CredentialScreen extends StatelessWidget {
  const CredentialScreen({super.key});

  void popUntilRoot(BuildContext context) {
    while (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Credential Screen")),
    );
  }
}
