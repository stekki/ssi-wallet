import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/graphql_service.dart';

import '../Models/models.dart';

class MessageService {
  late Map<String, dynamic> _result;
  late List<Message> _gqlMessages;

  Future<Map<String, dynamic>> getMessages(String nodeID) async {
    _result = await GraphQLService().getMessageByNodeId(nodeID);
    _gqlMessages = _result['connection']['messages']['nodes']
        .map<Message>((m) => Message.fromJson(m))
        .toList();
    return _result;
  }

  Future<List<Message>> fetchMessages(String nodeID) async {
    await getMessages(nodeID);
    return _gqlMessages;
  }
}

final messagesFutureProvider = FutureProvider.family<List<Message>, String>(
  (ref, nodeID) async {
    final messageService = MessageService();
    await messageService.getMessages(nodeID);
    await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
    return messageService.fetchMessages(nodeID);
  },
);
