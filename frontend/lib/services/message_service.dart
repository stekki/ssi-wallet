import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../services/queries.dart';
import 'package:frontend/services/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

Future<bool> sendProofRequest(String connectionId) async {
  final List<Map<String, dynamic>> attributes = [
    {
      'name': 'harri',
      'credDefId': '1234',
    },
  ];
  final Map<String, dynamic> variables = {
    'input': {
      'connectionId': connectionId,
      'attributes': attributes, 
    },
  };

  final result = await GraphQLService()
      .performMutation(GraphQLService().sendRequestProofMutation, variables);
  if (result['sendProofRequest']['ok']) {
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

final messageStreamProvider =
    StreamProvider.family<List<Message>, String>((ref, connectionID) {
  final stream = GraphQLService()
      .client
      .watchQuery(
        WatchQueryOptions(
          fetchResults: true,
          document: messagesQuery,
          variables: {'id': connectionID},
        ),
      )
      .stream
      .map((event) {
    try {
      final List<dynamic> res = event.data?["connection"]["messages"]["edges"];
      final List<Message> messages = res.map((e) {
        final node = e?["node"];
        return Message.fromJson(node);
      }).toList();
      return messages;
    } catch (e) {
      return <Message>[];
      //throw Exception("No data returned");
    }
  });
  return stream;
});
