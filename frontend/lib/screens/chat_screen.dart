import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  /*
  void popUntilRoot(BuildContext context) {
    while (context.canPop()) {  
      context.pop();
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.purple,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Findy Wallet"),
        backgroundColor: Colors.purple,
        actions: [
          TextButton(
              onPressed: () {
                context.go('/');
              },
              style: style,
              child: const Column(
                  children: [Icon(Icons.logout_rounded), Text('Logout')]))
        ],
      ),
      body: const Center(
        child: Text("Chat screen"),
      ),
    );
  }
}
