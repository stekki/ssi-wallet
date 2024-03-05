import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/chat_bottom_sheet.dart';
import 'package:frontend/widgets/message.dart';
// import '../models/models.dart';
import '../services/message_service.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String id;
  const ChatScreen(this.id, {super.key});

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
        ref.watch(messageStreamProvider(widget.id));
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
              _scrollToBottom();
              return Column(
                children: [
                  Expanded(
                    child: messages.isEmpty
                        ? const Center(child: Text("No messages yet"))
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return ChatMessageWidget(
                                message: message.message,
                                sentBy: message.sentByMe ? 'me' : 'other',
                                timestamp: message.createdAt,
                              );
                            },
                          ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const ChatBottomSheet(),
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
