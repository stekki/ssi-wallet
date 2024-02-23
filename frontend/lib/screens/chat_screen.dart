import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/providers/providers.dart';
import 'package:frontend/widgets/message.dart';
import '../models/models.dart';
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

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Message>> messagesAsyncValue =
        ref.watch(messagesFutureProvider(widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Container(
        child: messagesAsyncValue.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text("Error: $error"),
            data: (messages) {
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
                              );
                            },
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
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
                            if (_textEditingController.text.trim().isNotEmpty) {
                              final messageText =
                                  _textEditingController.text.trim();
                              final bool messageSent = await ref
                                  .read(messageServiceProvider)
                                  .sendMessage(widget.id, messageText);
                              if (messageSent) {
                                _textEditingController.clear();
                                // Optionally, trigger a refresh of the messages list
                                // ignore: unused_result
                                ref.refresh(messagesFutureProvider(widget.id));
                                // Scroll to the bottom of the chat to show the new message
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent +
                                      100.0, // Offset to ensure visibility
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              } else {
                                /*
                                // Show an error if the message was not sent
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to send message.'),
                                  ),
                                );
                                */
                              }
                            }
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
