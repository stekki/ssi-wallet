import 'package:frontend/Models/message_model.dart';

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
