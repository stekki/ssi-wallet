class Message {
  final String id;
  final String message;
  final bool sentByMe;
  final bool? delivered;
  final String createdMs;

  const Message({
    required this.id,
    required this.message,
    required this.sentByMe,
    required this.delivered,
    required this.createdMs,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      sentByMe: json['sentByMe'],
      delivered: json['delivered'],
      createdMs: json['createdMs'],
    );
  }
}
