import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/job_service.dart';

import '../providers/providers.dart';

class ChatBottomSheetSeller extends ConsumerWidget {
  final String id;
  const ChatBottomSheetSeller(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> chatStateList = ref.watch(chatStatusProvider);

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
                    child: !chatStateList.contains(id)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: double
                                    .infinity, // Ensure the button takes full width
                                height: 40,
                                child: ElevatedButton(
                                  // SELLER
                                  child: const Text('Confirm connection'),
                                  onPressed: () async => {
                                    Navigator.pop(context),
                                    await JobService.sendProofRequest(id),
                                    /*
                                    ref
                                        .watch(chatStatusProvider.notifier)
                                        .updateChatStatus(id),
                                        */
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
                                  child: const Text('Delete connection'),
                                  onPressed: () => {
                                    Navigator.pop(context),
                                  },
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Text("Waiting for the buyer..."),
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

class ChatBottomSheetBuyer extends ConsumerWidget {
  final String id;
  const ChatBottomSheetBuyer(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> chatStateList = ref.watch(chatStatusProvider);
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
                    child: chatStateList.contains(id)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: double
                                    .infinity, // Ensure the button takes full width
                                height: 40,
                                child: ElevatedButton(
                                  // BUYER
                                  child: const Text('Request receipt'),
                                  onPressed: () => {
                                    Navigator.pop(context),
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
                                  child: const Text('Delete connection'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Text("Waiting for the seller..."),
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
