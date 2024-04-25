import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_chat_card.dart';
import '../utils/styles.dart';

class ProofRequestCompleteWidget extends AbstractChatCard {
  
  ProofRequestCompleteWidget({
    super.key,
    super.node
  });
  
  @override String getSentBy(Map<String, dynamic>? node) {
    return node!["role"];
  }

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
            const Text('Identification provided'),
            const SizedBox(height: 4),
            Text(
              formatTime,
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
