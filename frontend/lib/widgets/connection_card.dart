import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:frontend/utils/styles.dart';

class ConnectionCard extends ConsumerWidget {
  final String name;

  const ConnectionCard({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () => {
          context.pushNamed("chat", pathParameters: {"chatID": name})
        },
        child: Column(
          children: [
            Ink(
              decoration: BoxDecoration(
                color: DesignColors.extraColorWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              height: max(height * 0.09, 60),
              child: ListTile(
                leading: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage('assets/logos/findywallet.png')),
                trailing: const Text("Tap to chat"),
                title: Text(name),
                subtitle: const Text("Target item"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              alignment: FractionalOffset.center,
                              image: AssetImage('assets/logos/findywallet.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 7,
                            top: 23,
                          ),
                          child: Text(
                            name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SingleChildScrollView(
                              child: Text(
                                "description",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

*/