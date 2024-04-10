import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/styles.dart';

class IDMessageWidget extends StatelessWidget {
  final String message;
  final String sentBy;
  final DateTime timestamp;

  const IDMessageWidget({
    super.key,
    required this.message,
    required this.sentBy,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    Color color = sentBy == 'me' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;

    if (sentBy == 'me') {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(0),
      );
    } else {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(10),
      );
    }

    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: sentBy == 'me' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: sentBy == 'me'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: DesignColors.textColor,
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              child: const Text('Im a seller (these buttons in development)'),
              onPressed: () => {},
            ),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: TextStyle(
                color: DesignColors.textColor.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicChatMessageWidget extends StatelessWidget {
  final String message;
  final String sentBy;
  final DateTime timestamp;

  const BasicChatMessageWidget({
    super.key,
    required this.message,
    required this.sentBy,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    Color color = sentBy == 'me' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;

    if (sentBy == 'me') {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(0),
      );
    } else {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(10),
      );
    }

    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: sentBy == 'me' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: sentBy == 'me'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: DesignColors.textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: TextStyle(
                color: DesignColors.textColor.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
