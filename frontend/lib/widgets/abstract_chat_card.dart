import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class AbstractChatCard extends StatelessWidget {
  final Map<String, dynamic>? node;
  late final String sentBy;
  late final String formatTime;

  AbstractChatCard({
    super.key,
    this.node,
  }) {
    formatTime = getFormatTime(node!["createdMs"]);
    sentBy = getSentBy(node);
  }

  String getFormatTime(createdMs){
    final timestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(createdMs));
    final formatTime = DateFormat('hh:mm a').format(timestamp);
    return formatTime;
    }

  String getSentBy(Map<String, dynamic>? node);

}
