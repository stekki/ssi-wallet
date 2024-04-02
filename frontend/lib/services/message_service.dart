import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import 'package:frontend/services/queries.dart';
import 'package:frontend/services/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MessageService {
  static final MessageService _instance = MessageService._();
  MessageService._();
  factory MessageService() {
    return _instance;
  }
  static QueryResult? fullResult;
  static List<Message> gqlMessages = [];
  static Map<String, dynamic> pageInfo = {};
  static final sendMessageMutation = gql("""
    mutation SendMessage(\$input: MessageInput!) {
      sendMessage(input: \$input) {
        ok
      }
    }""");

  // Get fresh data from the server
  Future<void> getMessages(String nodeID) async {
    try {
      await GraphQLService().getQueryResult(messagesQuery, {'id': nodeID});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getMoreMessages(String nodeID) async {
    final cursor = pageInfo["startCursor"];
    try {
      // fullResult should be not null
      if (fullResult == null) {
        getMessages(nodeID);
        return;
      }
      await GraphQLService().fetchMore(messagesQuery, {'id': nodeID},
          fullResult!, true, cursor, "messages", "connection");
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> sendMessage(String connectionId, String messageText) async {
    final variables = {
      'input': {
        'connectionId': connectionId,
        'message': messageText,
      },
    };
    final result =
        await GraphQLService().performMutation(sendMessageMutation, variables);
    return result['sendMessage']['ok'];
  }

  Future<List<Message>> fetchMessages(String nodeID) async {
    await getMessages(nodeID);
    return gqlMessages;
  }

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
        fullResult = event;
        final List<dynamic> res =
            event.data?["connection"]["messages"]["edges"];
        gqlMessages = res.map((e) {
          final node = e?["node"];
          return Message.fromJson(node);
        }).toList();
        pageInfo = event.data?["connection"]["messages"]["pageInfo"];
        return gqlMessages;
      } catch (e) {
        fullResult = null;
        gqlMessages = [];
        pageInfo = {};
        return gqlMessages;
        //throw Exception("No data returned");
      }
    });
    return stream;
  });

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
}
