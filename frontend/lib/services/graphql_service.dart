import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/graphql_config.dart';

class GraphQLService {
  static get nodeId => null;

  static final getIdQuery = gql("""
  query {
    user {
      id,
      name,
    }

  }""");

  static final invitationQuery = gql("""
  mutation {
      invite {
          id,
          endpoint,
          label,
          raw,
          imageB64
      }
  }""");

  static final sendRequestProofMutation = gql("""
  mutation SendProofRequest(\$input: ProofRequestInput!) {
    sendProofRequest(input: \$input) {
      ok
    }
  }
""");

  static Future<Map<String, dynamic>> performMutation(
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

  static Future<Map<String, dynamic>> getQueryResult(
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

  static Map<String, dynamic>? relayMerge(
      dynamic query,
      Map<String, dynamic> variables,
      bool before,
      Map<String, dynamic>? prevResult,
      Map<String, dynamic>? fetchMoreResult,
      String nodeName,
      String parentName) {
    final Map<String, dynamic>? prevResult = GraphQLConfig.client!.readQuery(
        Request(operation: Operation(document: query), variables: variables));
    Map<String, dynamic>? fetchMoreData = fetchMoreResult;
    if (fetchMoreData == null || fetchMoreData.isEmpty) {
      return prevResult;
    }
    final tempPrev = (parentName == '') ? prevResult : prevResult![parentName];
    final tempMore =
        (parentName == '') ? fetchMoreData : fetchMoreData[parentName];
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
        ? fetchMoreData[nodeName]["edges"] = meregedEdges
        : fetchMoreData[parentName][nodeName]["edges"] = meregedEdges;
    if (before) {
      (parentName == '')
          ? fetchMoreData[nodeName]["pageInfo"]["hasNextPage"] =
              prevResult![nodeName]["pageInfo"]["hasNextPage"]
          : fetchMoreData[parentName][nodeName]["pageInfo"]["hasNextPage"] =
              prevResult![parentName][nodeName]["pageInfo"]["hasNextPage"];
    } else {
      (parentName == '')
          ? fetchMoreData[nodeName]["pageInfo"]["hasPreviousPage"] =
              prevResult![nodeName]["pageInfo"]["hasPreviousPage"]
          : fetchMoreData[parentName][nodeName]["pageInfo"]["hasPreviousPage"] =
              prevResult![parentName][nodeName]["pageInfo"]["hasPreviousPage"];
    }
    return fetchMoreData;
  }

  static Future<Map<String, dynamic>?> fetchMore(
      dynamic query,
      Map<String, dynamic> variables,
      bool before,
      String cursor,
      String nodeName,
      String parentName) async {
    try {
      final fetchMoreVariables = {...variables, "cursor": cursor};
      QueryOptions queryOption = QueryOptions(
          document: query,
          variables: fetchMoreVariables,
          errorPolicy: ErrorPolicy.all,
          fetchPolicy: FetchPolicy.networkOnly);
      QueryResult fetchMoreResult = await GraphQLConfig.client!.query(
        queryOption,
      );
      Map<String, dynamic>? fetchMoreData = fetchMoreResult.data;
      return fetchMoreData;
    } catch (error) {
      throw Exception(error);
    }
  }
}
