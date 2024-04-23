import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import 'package:frontend/utils/styles.dart';

final connectionCardColorProvider = StateProvider<Color>((ref) {
  final iconColors = [
    const Color.fromARGB(255, 193, 135, 250),
    const Color.fromARGB(255, 80, 240, 230),
    const Color.fromARGB(255, 96, 235, 152),
    const Color.fromARGB(255, 121, 183, 255),
    Colors.orange,
  ];
  return iconColors[Random().nextInt(iconColors.length)];
});

class ConnectionCard extends ConsumerWidget {
  final Connection connection;

  const ConnectionCard({
    required this.connection,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final color =
        ref.watch(connectionCardColorProvider); // Get color from provider

    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          context.pushNamed("chat", pathParameters: {
            "id": connection.id,
            "isInvited": connection.invited ? '1' : '0'
          });
        },
        child: Ink(
          decoration: const BoxDecoration(
            color: DesignColors.extraColorWhite,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0,
              ),
            ),
          ),
          height: max(height * 0.11, 80),
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: color,
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
              title: Text(connection.theirLabel,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle:
                  const Text("Target item", style: TextStyle(fontSize: 16)),
              trailing: const Text(
                "Tap to chat",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
