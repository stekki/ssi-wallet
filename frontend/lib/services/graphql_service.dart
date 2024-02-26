import 'package:graphql_flutter/graphql_flutter.dart';
import '../config/graphql_config.dart';

class GraphQLService {
  static final GraphQLService _instance = GraphQLService._();
  GraphQLService._();
  factory GraphQLService() {
    return _instance;
  }

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

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

  final getMessagesQuery = gql("""
    query {
      connections(first: 5) {
        nodes {
          id
          ourDid
          theirDid
          theirEndpoint
          theirLabel
          createdMs
          approvedMs
          invited
          messages(last: 10) {
            nodes {
              id
              message
              sentByMe
              connection {
                id
              }
            }
          }
        }
      }
    }""");

  final getConnectionsQuery = gql("""
    query {
      connections(first: 5) {
        nodes {
          id
          ourDid
          theirDid
          theirEndpoint
          theirLabel
          createdMs
          approvedMs
          invited
        }
      }
    }""");

  final getMessagesByNodeIdQuery = gql("""
    query GetMessageByNodeId(\$nodeId: ID!) {
      connection(id: \$nodeId) {
        id
        messages(first: 10) {
          nodes {
            id
            message
            sentByMe
            delivered
            createdMs
          }
        }
      }
    }""");

  final sendMessageMutation = gql("""
    mutation SendMessage(\$input: MessageInput!) {
      sendMessage(input: \$input) {
        ok
      }
    }""");

  Future<Map<String, dynamic>> getMessageByNodeId(String nodeId) async {
    return await getQueryResult(getMessagesByNodeIdQuery, {'nodeId': nodeId});
  }

  Future<Map<String, dynamic>> performMutation(
      dynamic mutation, Map<String, dynamic> variables) async {
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
    try {
      QueryResult result = await client.query(QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
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
}
