import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/graphql_service.dart';
import 'package:frontend/services/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class JobService {
  static final JobService _instance = JobService._();
  JobService._();
  factory JobService() {
    return _instance;
  }
  static QueryResult? fullResult;
  static List<Map<String, dynamic>> gqlJobs = [];
  static Map<String, dynamic> pageInfo = {};

  // Query

  Future<void> getJobs(String connectionID) async {
    try {
      await GraphQLService().getQueryResult(
        connectionMockQuery,
        {'id': connectionID},
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getMoreJobs(String nodeID) async {
    final cursor = pageInfo["startCursor"];
    try {
      // fullResult should be not null
      if (fullResult == null) {
        getJobs(nodeID);
        return;
      }
      await GraphQLService().fetchMore(connectionMockQuery, {'id': nodeID},
          fullResult!, true, cursor, "events", "connection");
    } catch (error) {
      throw Exception(error);
    }
  }

  // Mutations:
  static final sendMessageMutation = gql("""
    mutation SendMessage(\$input: MessageInput!) {
      sendMessage(input: \$input) {
        ok
      }
    }""");

  static final sendRequestProofMutation = gql("""
  mutation SendProofRequest(\$input: ProofRequestInput!) {
    sendProofRequest(input: \$input) {
      ok
    }
  }
""");

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
        .performMutation(sendRequestProofMutation, variables);
    if (result['sendProofRequest']['ok']) {
      return true;
    } else {
      return false;
    }
  }

  final jobStreamProvider =
      StreamProvider.family<List<Map<String, dynamic>>, String>(
          (ref, connectionID) {
    final stream = GraphQLService()
        .client
        .watchQuery(
          WatchQueryOptions(
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            fetchResults: true,
            document: connectionMockQuery,
            variables: {'id': connectionID},
          ),
        )
        .stream
        .map((job) {
      try {
        fullResult = job;
        final List<dynamic> res = job.data?["connection"]["events"]["edges"];
        gqlJobs = res.map((e) {
          final Map<String, dynamic> node = e?["node"];
          return node;
        }).toList();
        pageInfo = job.data?["connection"]["events"]["pageInfo"];
        return gqlJobs;
      } catch (e) {
        fullResult = null;
        gqlJobs = [];
        pageInfo = {};
        return gqlJobs;
        //throw Exception("No data returned");
      }
    });
    return stream;
  });
}
