import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final String message;
  final String sentBy;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.sentBy,
  });

  @override
  Widget build(BuildContext context) {
    Color color = sentBy == 'me' ? Colors.blue : Colors.green;

    return Align(
      alignment: sentBy == 'me' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
