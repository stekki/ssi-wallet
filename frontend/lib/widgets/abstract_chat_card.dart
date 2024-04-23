import 'package:flutter/material.dart';

abstract class AbstractChatCard extends StatelessWidget {
  final String sentBy;
  final DateTime timestamp;

  const AbstractChatCard({
    super.key,
    required this.sentBy,
    required this.timestamp,
  });
}
