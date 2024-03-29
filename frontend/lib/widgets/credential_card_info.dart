import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/utils/styles.dart';

class CredentialCardInfo extends ConsumerWidget {
  final String date;
  final String holder;

  const CredentialCardInfo({
    required this.date,
    required this.holder,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignColors.secondaryColor.withOpacity(0),
          borderRadius: BorderRadius.circular(8),
        ),
        height: max(height * 0.1, 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 7,
                      top: 7,
                    ),
                    child: Text(
                      "Purchase date: $date",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SingleChildScrollView(
                        child: Text(
                          "Holder: $holder",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 10, 0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () => {},
                      style: TextButton.styleFrom(
                          backgroundColor: DesignColors.devRed),
                      child: const Text("Delete")),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton(
                      onPressed: () => {},
                      style: TextButton.styleFrom(
                          backgroundColor: DesignColors.buttonColor),
                      child: const Text(" Send ")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
