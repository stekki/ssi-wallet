import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/message.dart';
import 'package:go_router/go_router.dart';
import '../utils/styles.dart';
import '../services/graphql_service.dart';
import '../Models/models.dart';
import '../services/message_service.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String id;
  const ChatScreen(this.id, {Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

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
          data: (messages) => Column(
            children: [
              Expanded(
                child: ListView.builder(
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
                      onPressed: () {
                        // sendMessage();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
