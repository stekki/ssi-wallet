import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/styles.dart';

class Message {
  final String id;
  final String message;
  final bool sentByMe;
  final bool delivered;
  final String createdMs;
  final String connection;

  const Message({
    required this.id,
    required this.message,
    required this.sentByMe,
    required this.delivered,
    required this.createdMs,
    required this.connection,
  });

  static const List<Message> messages = [
    Message(
      id: '1',
      message: 'Hey, how are you?',
      sentByMe: false,
      delivered: true,
      createdMs: '1634567890000',
      connection: 'user1_user2',
    ),
    Message(
      id: '2',
      message: 'I\'m good, thanks! How about you?',
      sentByMe: true,
      delivered: true,
      createdMs: '1634567900000',
      connection: 'user1_user2',
    ),
    Message(
      id: '3',
      message: 'I\'m doing great too!',
      sentByMe: false,
      delivered: true,
      createdMs: '1634567910000',
      connection: 'user1_user2',
    ),
    Message(
      id: '4',
      message: 'That\'s awesome!',
      sentByMe: true,
      delivered: true,
      createdMs: '1634567920000',
      connection: 'user1_user2',
    ),
    Message(
      id: '5',
      message: 'By the way, did you watch the latest movie?',
      sentByMe: false,
      delivered: true,
      createdMs: '1634567930000',
      connection: 'user1_user2',
    ),
    Message(
      id: '6',
      message: 'Yes, it was amazing!',
      sentByMe: true,
      delivered: true,
      createdMs: '1634567940000',
      connection: 'user1_user2',
    ),
  ];
}

class Chat {
  final String connection;
  final List<Message> messages;

  const Chat({
    required this.connection,
    required this.messages,
  });

  Chat copyWith({
    String? connection,
    List<Message>? messages,
  }) {
    return Chat(
      connection: connection ?? this.connection,
      messages: messages ?? this.messages,
    );
  }

  static List<Chat> chats = [
    const Chat(
      connection: 'user1_user2',
      messages: Message.messages,
    ),
  ];
}

class ChatScreen extends StatelessWidget {
  final String? chatID;
  const ChatScreen({super.key, required this.chatID});

  /*
  void popUntilRoot(BuildContext context) {
    while (context.canPop()) {  
      context.pop();
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            chatID ?? "Chat screen",
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
            ListView.builder(
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
            const Divider(
              height: 4,
              color: DesignColors.secondaryColor,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
