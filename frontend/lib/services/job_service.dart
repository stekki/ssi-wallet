import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/graphql_config.dart';
import 'package:frontend/services/graphql_service.dart';
import 'package:frontend/services/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class JobService {
  Map<String, dynamic>? fullJobResult;
  List<Map<String, dynamic>> gqlJobs = [];
  // PageInfo of events
  Map<String, dynamic> eventPageInfo = {};
  String connectionID;
  // Constructor
  JobService(this.connectionID);
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

  static Future<bool> sendMessage(
      String connectionId, String messageText) async {
    final variables = {
      'input': {
        'connectionId': connectionId,
        'message': messageText,
      },
    };
    final result =
        await GraphQLService.performMutation(sendMessageMutation, variables);
    return result['sendMessage']['ok'];
  }

  static Future<bool> sendProofRequest(String connectionId) async {
    final List<Map<String, dynamic>> attributes = [
      {
        'name': 'name',
        'credDefId': 'VBywCZLA71hafiMBEMj2Kz:3:CL:14:SuomenValtio',
      },
    ];
    final Map<String, dynamic> variables = {
      'input': {
        'connectionId': connectionId,
        'attributes': attributes,
      },
    };

    final result = await GraphQLService.performMutation(
        sendRequestProofMutation, variables);
    if (result['sendProofRequest']['ok']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> sendResumeJobMutation(String jobId, bool accept) async {
    final Map<String, dynamic> variables = {
      'input': {
        'id': jobId,
        'accept': accept,
      },
    };
    final result =
        await GraphQLService.performMutation(resumeJobMutation, variables);
    if (result['resume']['ok']) {
      return true;
    } else {
      return false;
    }
  }

  // Object function of job service
  static Map<String, dynamic> updateJobFromEvent(fullEvents) {
    final List<dynamic>? eventEdges =
        fullEvents["connection"]["events"]["edges"];
    final List<String> jobEdgeID = [];
    final List<dynamic> jobEdges = [];
    for (var edge in eventEdges!) {
      if (!jobEdgeID.contains(edge["node"]["job"]["node"]["id"])) {
        jobEdgeID.add(edge["node"]["job"]["node"]["id"]);
        jobEdges.add(edge["node"]["job"]);
      }
    }
    final pageInfo = fullEvents["connection"]["events"]["pageInfo"];
    final Map<String, dynamic> fullJobs = {
      "__typename": "Query",
      "connection": {
        "__typename": "Pairwise",
        "jobs": {
          "__typename": "JobConnection",
          "edges": jobEdges,
          "pageInfo": pageInfo
        }
      }
    };
    return fullJobs;
  }

  // Direct connectionJobQuery is not supported by the backend,
  // get the data from eventQuery instead and init the
  // job query data.
  Future<void> initJobStream() async {
    try {
      final Map<String, dynamic> fullEvents =
          await GraphQLService.getQueryResult(
        connectionMockQuery,
        {'id': connectionID},
      );
      Map<String, dynamic> fullJobs = updateJobFromEvent(fullEvents);
      final variables = {"id": connectionID};
      final queryRequest = Request(
          operation: Operation(document: connectionJobsQuery),
          variables: variables);
      GraphQLConfig.client!.writeQuery(queryRequest, data: fullJobs);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getMoreJobs() async {
    try {
      // fullResult should be not null
      if (fullJobResult == null) {
        return;
      }
      if (!eventPageInfo["hasPreviousPage"]) {
        return;
      }
      // Get more event data
      final cursor = eventPageInfo["startCursor"];
      Map<String, dynamic>? fetchMoreResult = await GraphQLService.fetchMore(
          connectionMockQuery,
          {'id': connectionID},
          true,
          cursor,
          "events",
          "connection");
      // Map event data to job data
      Map<String, dynamic> moreJobResult = updateJobFromEvent(fetchMoreResult);
      Map<String, dynamic>? mergeJobResult = GraphQLService.relayMerge(
          connectionJobsQuery,
          {'id': connectionID},
          true,
          fullJobResult,
          moreJobResult,
          "jobs",
          "connection");
      final queryRequest = Request(
          operation: Operation(document: connectionJobsQuery),
          variables: {'id': connectionID});
      GraphQLConfig.client!.writeQuery(queryRequest, data: mergeJobResult!);
    } catch (error) {
      throw Exception(error);
    }
  }

  StreamProvider<List<Map<String, dynamic>>> jobStreamProvider() =>
      StreamProvider<List<Map<String, dynamic>>>((ref) {
        final GraphQLClient client = GraphQLConfig.client!;
        final stream = client
            .watchQuery(
              WatchQueryOptions(
                fetchPolicy: FetchPolicy.cacheOnly,
                fetchResults: true,
                document: connectionJobsQuery,
                variables: {'id': connectionID},
              ),
            )
            .stream
            .map((job) {
          try {
            fullJobResult = job.data;
            final List<dynamic> res = job.data?["connection"]["jobs"]["edges"];
            gqlJobs = res.where((element) => element != null).map((e) {
              final Map<String, dynamic> node = e?["node"];
              return node;
            }).toList();
            return gqlJobs;
          } catch (e) {
            fullJobResult = {};
            gqlJobs = [];
            return gqlJobs;
            //throw Exception("No data returned");
          }
        });
        return stream;
      });
}
