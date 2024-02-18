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
      connection: 'Pisshead',
    ),
    Message(
      id: '2',
      message: 'I\'m good, thanks! How about you?',
      sentByMe: true,
      delivered: true,
      createdMs: '1634567900000',
      connection: 'Pisshead',
    ),
    Message(
      id: '3',
      message: 'I\'m doing great too!',
      sentByMe: false,
      delivered: true,
      createdMs: '1634567910000',
      connection: 'Pisshead',
    ),
    Message(
      id: '4',
      message: 'That\'s awesome!',
      sentByMe: true,
      delivered: true,
      createdMs: '1634567920000',
      connection: 'Pisshead',
    ),
    Message(
      id: '5',
      message: 'By the way, did you watch the latest movie?',
      sentByMe: false,
      delivered: true,
      createdMs: '1634567930000',
      connection: 'Pisshead',
    ),
    Message(
      id: '6',
      message: 'Yes, it was amazing!',
      sentByMe: true,
      delivered: true,
      createdMs: '1634567940000',
      connection: 'Pisshead',
    ),
  ];
}
