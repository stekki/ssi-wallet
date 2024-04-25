import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/chat_bottom_sheet.dart';
import 'package:frontend/widgets/proof_request_complete.dart';
import 'package:frontend/widgets/proof_request_complete_seller.dart';
import 'package:frontend/widgets/proof_request_widget.dart';
import 'package:frontend/widgets/basic_message_widget.dart';
import 'package:frontend/widgets/proof_request_widget_buyer.dart';
import 'package:frontend/widgets/proof_request_widget_seller.dart';
import '../providers/providers.dart';
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
        final chatStatus = ref.read(chatStatusProvider);

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
                                  final job = events[index];
                                  final protocol = job["protocol"];
                                  switch (protocol) {
                                    case 'BASIC_MESSAGE': return BasicChatMessageWidget(
                                      node: job["output"]["message"]["node"]
                                    );
                                    case 'PROOF': {
                                      final proofRequest =
                                        job["output"]["proof"]["node"];
                                      final role = proofRequest['role'];
                                      if (role == 'VERIFIER') {
                                        if (job["status"] == 'COMPLETE') {
                                          return ProofRequestCompleteSellerWidget(node: proofRequest);
                                        }
                                        else if (job["status"] == 'WAITING') {
                                          return ProofRequestWidget(node: proofRequest);
                                        }
                                        else {
                                          return Container();
                                        }
                                      }
                                      else if (role == "PROVER") {
                                        if(job["status"] == 'COMPLETE' && chatStatus[widget.id] == ConnectionStatus.receipted) {
                                          return Container();
                                        }
                                        else if(job["status"] == 'WAITING' && chatStatus[widget.id] == ConnectionStatus.confirmed) {
                                          return ProofRequestWidgetSeller(
                                          key: ValueKey(job['id']),
                                          sentBy: proofRequest["role"],
                                          timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(proofRequest["createdMs"])),
                                          jobID: job["id"],
                                          id: widget.id,
                                          status: job["status"]);
                                        }
                                        else if(job["status"] == 'COMPLETE') {
                                          return ProofRequestCompleteWidget(node: proofRequest);
                                        } else {
                                          return ProofRequestWidgetBuyer(
                                          key: ValueKey(job['id']),
                                          sentBy: proofRequest["role"],
                                          timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(proofRequest["createdMs"])),
                                          jobID: job["id"],
                                          id: widget.id,
                                          status: job["status"]);
                                        }
                                        
                                        
                                      }
                                    }
                                    default: return Container();
                                  }
                                  return Container();
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
