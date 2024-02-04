import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class CredentialCard extends ConsumerWidget {
  final String name;

  const CredentialCard({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return InkWell(
        // TODO: implement onTap to expand the credentialCard
        //onTap: () => ,
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Ink(
            decoration: BoxDecoration(
              color: Color.fromARGB(125, 222, 222, 222),
              borderRadius: BorderRadius.circular(8),
            ),
            height: max(height * 0.12, 50),
            child: Row(
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.expand_more,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
