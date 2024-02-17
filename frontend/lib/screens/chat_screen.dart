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
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: DesignColors.mainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(chatID ?? "Chat screen"),
        backgroundColor: DesignColors.mainColor,
        actions: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            style: style,
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
