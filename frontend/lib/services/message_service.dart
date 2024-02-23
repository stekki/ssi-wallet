import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/graphql_service.dart';

import '../models/models.dart';

class MessageService {
  late Map<String, dynamic> _result;
  late List<Message> _gqlMessages = [];

  Future<Map<String, dynamic>> getMessages(String nodeID) async {
    try {
      _result = await GraphQLService().getMessageByNodeId(nodeID);
      if (_result['errors'] != null) {
        //print('GraphQL Error: ${_result['errors']}');
        _gqlMessages = [];
      } else if (_result['connection'] != null &&
          _result['connection']['messages'] != null &&
          _result['connection']['messages']['nodes'] != null) {
        _gqlMessages = _result['connection']['messages']['nodes']
            .map<Message>((m) => Message.fromJson(m))
            .toList();
      } else {
        _gqlMessages = []; // Ensure the list is empty if no messages are found
      }
    } catch (e) {
      //print('Exception occurred: $e');
      _gqlMessages = []; // Ensure the list is empty if an exception occurred
    }
    return _result;
  }

  Future<bool> sendMessage(String connectionId, String messageText) async {
    final variables = {
      'input': {
        'connectionId': connectionId,
        'message': messageText,
      },
    };
    final result = await GraphQLService()
        .performMutation(GraphQLService().sendMessageMutation, variables);
    if (result['sendMessage']['ok']) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Message>> fetchMessages(String nodeID) async {
    await getMessages(nodeID);
    return _gqlMessages;
  }
}

final messagesFutureProvider = FutureProvider.family<List<Message>, String>(
  (ref, nodeID) async {
    try {
      final messageService = MessageService();
      await messageService.getMessages(nodeID);
      await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
      return messageService.fetchMessages(nodeID);
    } catch (e) {
      //print('Error fetching messages: $e');
      return [];
    }
  },
);
