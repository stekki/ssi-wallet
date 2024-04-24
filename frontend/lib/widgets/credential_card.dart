import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/credential_model.dart';

import 'package:frontend/utils/styles.dart';

final credentialCardColorProvider =
    StateProvider.family<Color, String>((ref, issuer) {
  final iconColors = [
    const Color.fromARGB(255, 193, 135, 250),
    const Color.fromARGB(255, 80, 240, 230),
    const Color.fromARGB(255, 96, 235, 152),
    const Color.fromARGB(255, 121, 183, 255),
    Colors.orange,
  ];
  Random random = Random(issuer.hashCode);
  return iconColors[random.nextInt(iconColors.length)];
});

class CredentialCard extends ConsumerWidget {
  final Credential credential;

  const CredentialCard({
    super.key,
    required this.credential,
  });

  static const validIcon = Icon(
    Icons.check,
    color: Colors.green,
  );
  static const invalidIcon = Icon(
    Icons.close,
    color: Colors.orange,
  );

  static const List<Color> iconColors = [
    Color.fromARGB(255, 193, 135, 250),
    Color.fromARGB(255, 80, 240, 230),
    Color.fromARGB(255, 96, 235, 152),
    Color.fromARGB(255, 121, 183, 255),
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(credentialCardColorProvider(
        credential.issuer)); // Get the color from the provider

    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align items vertically center
        children: <Widget>[
          CircleAvatar(
            backgroundColor:
                color, // Use random color for the background, now consistent across rebuilds
            radius: 25, // Size of the circle avatar
            child: Text(
              credential.issuer.isNotEmpty ? credential.issuer[0] : '?',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24), // First letter with styling
            ),
          ),
          const SizedBox(width: 8), // Space between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Fit content in minimum space
              children: [
                Text(credential.issuer),
                Text(credential.item,
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: DesignColors.secondaryColor.withOpacity(0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Issuance date: ${credential.date}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              "Holder: ${credential.holder}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Status: ${credential.status} ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  (credential.status.toLowerCase() == 'valid')
                                      ? validIcon
                                      : invalidIcon,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                      child: TextButton(
                          onPressed: () => {},
                          style: TextButton.styleFrom(
                              backgroundColor: DesignColors.buttonColor),
                          child: const Text("Send")),
                    ),
                    */
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
