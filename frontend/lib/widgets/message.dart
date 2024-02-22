import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final String message;
  final String sentBy;

  const ChatMessageWidget({
    Key? key,
    required this.message,
    required this.sentBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = sentBy == 'me' ? Colors.blue : Colors.green;

    return Align(
      alignment: sentBy == 'me' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
