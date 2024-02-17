import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/styles.dart';

class ChatScreen extends StatelessWidget {
  final String? chatID;
  const ChatScreen({super.key, required this.chatID});

  /*
  void popUntilRoot(BuildContext context) {
    while (context.canPop()) {  
      context.pop();
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatID ?? "Chat screen",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Tooltip(
              message: "Log out",
              child: Icon(Icons.logout_rounded),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("Chat screen"),
      ),
    );
  }
}
