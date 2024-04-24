import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/abstract_chat_card.dart';
import 'package:intl/intl.dart';

class ProofRequestWidget extends AbstractChatCard {
  //final DateTime verifiedAt;
  //final DateTime approvedAt;

  const ProofRequestWidget({
    super.key,
    required super.sentBy,
    required super.timestamp,
    //required this.verifiedAt,
    //required this.approvedAt,
  });

  @override
  Widget build(BuildContext context) {
    Color color =
        sentBy == 'VERIFIER' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;
    if (sentBy == 'VERIFIER') {
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
      alignment:
          sentBy == 'VERIFIER' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: sentBy == 'VERIFIER'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            const Text('Identification requested'),
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