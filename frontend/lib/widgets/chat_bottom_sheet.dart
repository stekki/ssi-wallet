import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class ChatBottomSheet extends ConsumerWidget {
  final String id;
  const ChatBottomSheet(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              double width = MediaQuery.of(context).size.width;
              return Container(
                height: 200,
                color: Colors.white,
                child: Center(
                  child: SizedBox(
                    width: width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: double
                              .infinity, // Ensure the button takes full width
                          height: 40,
                          child: ElevatedButton(
                            child: const Text('Accept chat'),
                            onPressed: () => {
                              ref
                                  .watch(chatStatusProvider.notifier)
                                  .updateChatStatus(id),
                              Navigator.pop(context)
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double
                              .infinity, // Ensure the button takes full width
                          height: 40,
                          child: ElevatedButton(
                            child: const Text('Delete chat'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
