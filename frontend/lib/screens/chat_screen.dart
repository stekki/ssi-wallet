import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../services/message_service.dart';
import '../utils/styles.dart';
import '../widgets/chat_bottom_sheet.dart';
import '../widgets/message.dart';

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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<dynamic>> streamMessages =
        ref.watch(MessageService().messageStreamProvider(widget.id));

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
          streamMessages.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text("Error: $error")),
            data: (messages) {
              if (messages.isNotEmpty) {
                _scrollToBottom();
              }
              return Column(
                children: [
                  Expanded(
                    child: messages.isEmpty
                        ? const Center(child: Text("No messages yet"))
                        : RefreshIndicator(
                            onRefresh: () async {
                              await MessageService().getMoreMessages(widget.id);
                            },
                            child: ScrollConfiguration(
                              behavior: MyCustomScrollBehavior(),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  return BasicChatMessageWidget(
                                    message: message.message,
                                    sentBy: message.sentByMe ? 'me' : 'other',
                                    timestamp: message.createdAt,
                                  );
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
                                final bool messageSent = await ref
                                    .read(messageServiceProvider)
                                    .sendMessage(widget.id, messageText);
                                if (messageSent) {
                                  _textEditingController.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar( 
                                    const SnackBar(
                                      content: Text('Failed to send message'),
                                      duration: Duration(seconds: 2)
                                      )
                                  );
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
