import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/chat_bottom_sheet.dart';
import 'package:frontend/widgets/message.dart';
// import 'package:frontend/widgets/message.dart';
// import '../models/models.dart';
import '../services/job_service.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class ChatScreen extends ConsumerStatefulWidget {
  final String id;
  final bool isInvited;
  const ChatScreen(this.id, this.isInvited, {super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  late JobService jobService;
  late StreamProvider<List<Map<String, dynamic>>> jobStream;

  @override
  void initState() {
    super.initState();
    jobService = JobService(widget.id);
    jobStream = jobService.jobStreamProvider();
    jobService.initJobStream();
  }

  void _scrollToBottom() async {
    await Future.delayed(Duration.zero);
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          100.0, // Offset to ensure visibility
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _showMessageSendFailure() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Failed to send message"),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Map<String, dynamic>>> streamEvents =
        ref.watch(jobStream);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: scaffoldBackground,
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          streamEvents.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text("Error: $error")),
            data: (events) {
              if (events.isNotEmpty) {
                _scrollToBottom();
              }
              return Column(
                children: [
                  Expanded(
                    child: events.isEmpty
                        ? const Center(child: Text("No messages yet"))
                        : RefreshIndicator(
                            onRefresh: () async {
                              await jobService.getMoreJobs();
                            },
                            child: ScrollConfiguration(
                              behavior: MyCustomScrollBehavior(),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  // final event = events[index];
                                  // final job = event["job"]["node"];
                                  final job = events[index];
                                  if (job["protocol"] == "BASIC_MESSAGE") {
                                    final message =
                                        job["output"]["message"]["node"];
                                    final messageText = message["message"];
                                    if ((message["sentByMe"]) &&
                                        (messageText ==
                                            'Buyer has accepted your identification request.')) {
                                      return Container();
                                    } else if ((message["sentByMe"]) &&
                                        (messageText ==
                                            'Buyer has denied your identification request.')) {
                                      return Container();
                                    } else {
                                      // Best if Component builder like BasicChatMessage
                                      // take the whole node (above) and handle it there.
                                      final createdAt =
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(message['createdMs']));
                                      return BasicChatMessageWidget(
                                          message: message["message"],
                                          sentBy: message["sentByMe"]
                                              ? 'me'
                                              : 'other',
                                          timestamp: createdAt);
                                    }
                                  } else if (job["protocol"] == "PROOF") {
                                    final proofRequest =
                                        job["output"]["proof"]["node"];
                                    final createdAt =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(
                                                proofRequest['createdMs']));
                                    /*
                                    final verifiedAt =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(proofRequest['verifiedMs']));
                                    final approvedAt =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(proofRequest['approvedMs']));
                                      */
                                    if (proofRequest['role'] == 'VERIFIER') {
                                      return ProofRequestWidget(
                                        key: ValueKey(job['id']),
                                        sentBy: proofRequest["role"],
                                        timestamp: createdAt,
                                      );
                                      //verifiedAt: verifiedAt,
                                      //approvedAt: approvedAt,);
                                    } else if ((proofRequest['role'] ==
                                            'PROVER') &&
                                        (job['status'] == 'COMPLETE')) {
                                      return ProofRequestCompleteWidget(
                                        key: ValueKey(job['id']),
                                        sentBy: proofRequest["role"],
                                        timestamp: createdAt,
                                      );
                                    } else if (proofRequest['role'] ==
                                        'PROVER') {
                                      return ProofRequestWidgetBuyer(
                                          key: ValueKey(job['id']),
                                          sentBy: proofRequest["role"],
                                          timestamp: createdAt,
                                          jobID: job["id"],
                                          id: widget.id,
                                          status: job["status"]);
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          widget.isInvited
                              ? ChatBottomSheetSeller(widget.id)
                              : ChatBottomSheetBuyer(widget.id),
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                hintText: "Type a message",
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (_textEditingController.text
                                  .trim()
                                  .isNotEmpty) {
                                final messageText =
                                    _textEditingController.text.trim();
                                final bool messageSent =
                                    await JobService.sendMessage(
                                        widget.id, messageText);
                                if (messageSent) {
                                  _textEditingController.clear();
                                } else {
                                  _showMessageSendFailure();
                                  // Optional: Show an error if the message was not sent
                                }
                              }
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
