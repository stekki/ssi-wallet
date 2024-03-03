class Message {
  final String id;
  final String message;
  final bool sentByMe;
  final bool? delivered;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.message,
    required this.sentByMe,
    required this.delivered,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    final createdAt =
        DateTime.fromMillisecondsSinceEpoch(int.parse(json['createdMs']));
    return Message(
      id: json['id'],
      message: json['message'],
      sentByMe: json['sentByMe'],
      delivered: json['delivered'],
      createdAt: createdAt,
    );
  }
}
