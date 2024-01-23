import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Findy Wallet"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            iconSize: 50,
            onPressed: () => context.pushNamed("chat"),
            icon: const Text(
              "Chat",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          IconButton(
            iconSize: 80,
            onPressed: () => context.pushNamed("credential"),
            icon: const Text(
              "Credentials",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
      body: const Center(child: Text("Home Screen")),
    );
  }
}
