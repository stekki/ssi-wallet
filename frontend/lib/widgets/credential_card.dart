import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'dart:math';

//import 'package:frontend/utils/styles.dart';

class CredentialCard extends ConsumerWidget {
  final String issuer;
  final String item;

  const CredentialCard({
    required this.issuer,
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final height = MediaQuery.of(context).size.height;

    return Card(
      child: ListTile(
        leading: const Icon(Icons.stars),
        title: Text(item),
        subtitle: Text(issuer),
      ),
    );
  }
}
