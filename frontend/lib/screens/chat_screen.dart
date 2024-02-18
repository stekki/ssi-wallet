import 'package:flutter/material.dart';
import 'package:frontend/Models/chat_model.dart';
import 'package:frontend/Models/message_model.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_theme.dart';
import '../utils/styles.dart';

import '../Models/models.dart';

class ChatScreen extends StatefulWidget {
  final String? chatID;
  const ChatScreen({super.key, required this.chatID});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();
  late String connection;
  late List<Message> messages;

  @override
  void initState() {
    super.initState();
    // connections are given as argument to the chat screen
    // messages are given as argument to the chat screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.chatID ?? "Chat screen",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/');
              },
              child: const Tooltip(
                message: "Log out",
                child: Icon(Icons.logout_rounded),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Chat.chats[0].messages.length,
                itemBuilder: (context, index) {
                  Message message = Chat.chats[0].messages[index];
                  return Align(
                    alignment: message.sentByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      decoration: BoxDecoration(
                        color: message.sentByMe
                            ? DesignColors.tertiaryColor
                            : DesignColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: message.sentByMe
                              ? DesignColors.secondaryColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(
              height: 4,
              color: DesignColors.secondaryColor,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        filled: true,
                        fillColor: DesignColors.secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
