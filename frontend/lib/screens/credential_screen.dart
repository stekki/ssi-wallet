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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Findy Wallet"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            iconSize: 50,
            onPressed: () => {
              popUntilRoot(context),
              context.replaceNamed("home"),
            },
            icon: const Text(
              "Home",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          IconButton(
            iconSize: 50,
            onPressed: () => context.replaceNamed("chat"),
            icon: const Text(
              "Chat",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
      body: const Center(child: Text("Credential Screen")),
    );
  }
}
