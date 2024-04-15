import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/graphql_config.dart';

class GraphQLService {
  static final GraphQLService _instance = GraphQLService._();
  GraphQLService._();
  factory GraphQLService() {
    return _instance;
  }

  static get nodeId => null;

  final getIdQuery = gql("""
  query {
    user {
      id,
      name,
    }

  }""");

  final invitationQuery = gql("""
  mutation {
      invite {
          id,
          endpoint,
          label,
          raw,
          imageB64
      }
  }""");

  final sendRequestProofMutation = gql("""
  mutation SendProofRequest(\$input: ProofRequestInput!) {
    sendProofRequest(input: \$input) {
      ok
    }
  }
""");

  Future<Map<String, dynamic>> performMutation(
      dynamic mutation, Map<String, dynamic> variables) async {
    final GraphQLClient client = GraphQLConfig.client!;
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: mutation, // This is your GraphQL mutation
          variables: variables, // These are the variables for your mutation
        ),
      );

      if (result.hasException) {
        //print(result.exception.toString());
        throw Exception(result.exception.toString());
      }

      Map<String, dynamic>? res = result.data;
      if (res == null) {
        throw Exception('Mutation returned null data');
      } else {
        return res;
      }
    } catch (error) {
      throw Exception('Error performing mutation: $error');
    }
  }

  Future<Map<String, dynamic>> getQueryResult(
      dynamic query, Map<String, dynamic> variables) async {
    // This function only fetch from the server
    // not from the cache
    final GraphQLClient client = GraphQLConfig.client!;
    try {
      QueryResult result = await client.query(QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: query,
          variables: variables,
          errorPolicy: ErrorPolicy.all));
      Map<String, dynamic>? res = result.data;
      if (res == null) {
        throw Exception("No data returned");
      } else {
        return res;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> fetchMore(
      dynamic query,
      Map<String, dynamic> variables,
      QueryResult prevResult,
      bool before,
      String cursor,
      String nodeName,
      String parentName) async {
    FetchMoreOptions opts = FetchMoreOptions(
        variables: {"cursor": cursor},
        updateQuery: (previousResult, fetchMoreResult) {
          if (fetchMoreResult == null || fetchMoreResult.isEmpty) {
            return previousResult;
          }
          final tempPrev =
              (parentName == '') ? previousResult : previousResult![parentName];
          final tempMore = (parentName == '')
              ? fetchMoreResult
              : fetchMoreResult[parentName];
          final List<dynamic> meregedEdges = before
              ? [
                  ...tempMore[nodeName]["edges"] as List<dynamic>,
                  ...tempPrev[nodeName]["edges"] as List<dynamic>,
                ]
              : [
                  ...tempPrev[nodeName]["edges"] as List<dynamic>,
                  ...tempMore[nodeName]["edges"] as List<dynamic>,
                ];
          (parentName == '')
              ? fetchMoreResult[nodeName]["edges"] = meregedEdges
              : fetchMoreResult[parentName][nodeName]["edges"] = meregedEdges;
          if (before) {
            (parentName == '')
                ? fetchMoreResult[nodeName]["pageInfo"]["hasNextPage"] =
                    previousResult![nodeName]["pageInfo"]["hasNextPage"]
                : fetchMoreResult[parentName][nodeName]["pageInfo"]
                        ["hasNextPage"] =
                    previousResult![parentName][nodeName]["pageInfo"]
                        ["hasNextPage"];
          } else {
            (parentName == '')
                ? fetchMoreResult[nodeName]["pageInfo"]["hasPreviousPage"] =
                    previousResult![nodeName]["pageInfo"]["hasPreviousPage"]
                : fetchMoreResult[parentName][nodeName]["pageInfo"]
                        ["hasPreviousPage"] =
                    previousResult![parentName][nodeName]["pageInfo"]
                        ["hasPreviousPage"];
          }
          return fetchMoreResult;
        });
    QueryOptions original = QueryOptions(
        document: query,
        variables: variables,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    try {
      final GraphQLClient client = GraphQLConfig.client!;
      QueryResult result = await client.fetchMore(opts,
          originalOptions: original, previousResult: prevResult);
      Map<String, dynamic>? res = result.data;
      if (res == null) {
        throw Exception("No data returned");
      } else {
        final queryRequest = Request(
            operation: Operation(document: query), variables: variables);
        client.writeQuery(queryRequest, data: res);
        return res;
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
